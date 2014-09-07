module Twitter
  module Cli
    class TwitterService
      include HTTParty
      base_uri 'https://api.twitter.com'
      format :json
      attr_reader :access_token

      def initialize consumer_key, consumer_secret
        @consumer_key     = consumer_key
        @consumer_secret  = consumer_secret
        @access_token = get_access_token
      end

      def base64_credentials
        url_encoded_credentials = "#{URI.encode(@consumer_key)}:#{URI.encode(@consumer_secret)}"
        Base64.encode64(url_encoded_credentials).gsub("\n", '')
      end

      def get_access_token
        response = self.class.post('/oauth2/token', {
          body: {
            grant_type: 'client_credentials'
          },
          headers: {
            'Authorization' => "Basic #{base64_credentials}"
          }
        })
        JSON.parse(response.body)['access_token']
      end

      def mentions(username, count=3)
        response = self.class.get('/1.1/search/tweets.json',
          query: {
            q: "@#{username}",
            count: count,
            result_type: 'recent'
          },
          headers: {
            'Authorization' => "Bearer #{@access_token}"
          }
        )
        JSON.parse(response.body)['statuses'].map do |status|
          {
            status: {
              username: status['user']['screen_name'],
              text: status['text'].gsub("\n", '')
            }
          }
        end
      end
    end
  end
end
