module Twitter
  module Cli
    class Runner < Thor::Shell::Basic
      def run
        say 'Hello! Let\'s access Twitter API to get information'
        say 'For this you will need to obtain consumer key and secret from https://apps.twitter.com/'
        consumer_key    = ask('Please input your consumer key:')
        consumer_secret = ask('Please input your secret:')
        say Twitter::Cli::TwitterService.new(consumer_key, consumer_secret).access_token
      end
    end
  end
end
