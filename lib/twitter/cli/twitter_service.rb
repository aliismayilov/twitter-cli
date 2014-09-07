module Twitter
  module Cli
    class TwitterService
      include HTTParty
      base_uri 'https://api.twitter.com'
      format :json
      attr_reader :base64_credentials

      def initialize consumer_key, consumer_secret
        @consumer_key     = consumer_key
        @consumer_secret  = consumer_secret
      end

      def base64_credentials
        url_encoded_credentials = "#{URI.encode(@consumer_key)}:#{URI.encode(@consumer_secret)}"
        Base64.encode64(url_encoded_credentials).gsub("\n", '')
      end
    end
  end
end
