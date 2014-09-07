module Twitter
  module Cli
    class TwitterService
      include HTTParty
      base_uri 'https://api.twitter.com'
      format :json

      def initialize consumer_key, consumer_secret
        @consumer_key     = consumer_key
        @consumer_secret  = consumer_secret
      end

      def base64_credentials
        url_encoded_credentials = "#{URI.encode(@consumer_key)}:#{URI.encode(@consumer_secret)}"
        Base64.encode64(url_encoded_credentials).gsub("\n", '')
      end

      def access_token
        @access_token ||= JSON.parse(get_access_token)['access_token']
      end

      def get_access_token
        self.class.post('/oauth2/token', {
          body: {
            grant_type: 'client_credentials'
          },
          headers: {
            'Authorization' => "Basic #{base64_credentials}"
          }
        }).body
      end

      def mentions(username, count=3)
        JSON.parse(get_mentions(username, count))['statuses'].map do |status|
          {
            username: status['user']['screen_name'],
            text: status['text'].gsub("\n", ' ')
          }
        end
      end

      def get_mentions(username, count)
        self.class.get('/1.1/search/tweets.json',
          query: {
            q: "@#{username}",
            count: count,
            result_type: 'recent'
          },
          headers: {
            'Authorization' => "Bearer #{access_token}"
          }
        ).body
      end
    end
  end
end
