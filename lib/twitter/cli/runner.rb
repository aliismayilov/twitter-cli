module Twitter
  module Cli
    class Runner < Thor::Shell::Basic
      def run
        greet
        consumer_key, consumer_secret = ask_for_consumer_credentials
        say 'We are getting the access token...'
        @twitter_service = Twitter::Cli::TwitterService.new(consumer_key, consumer_secret)
        while (@twitter_service.access_token)
          find_mentions
        end
        say 'We could not get an access token with the provided consumer key and secret' unless @twitter_service.access_token
      end

      def greet
        say 'Hello! Let\'s access Twitter API to get information'
        say 'For this you will need to obtain consumer key and secret from https://apps.twitter.com/'
      end

      def ask_for_consumer_credentials
        consumer_key    = ask('Please input your consumer key:')
        consumer_secret = ask('Please input your secret:')
        [consumer_key, consumer_secret]
      end

      def print_statuses(statuses)
        statuses.each do |status|
          say "@#{status[:username]} said:  "
          say "#{status[:text]}"
        end
      end

      def find_mentions
        username = ask('Search for the latest 3 user mentions. Please enter any username (without @):')
        return if username.empty?
        say '====='
        statuses = @twitter_service.mentions(username)
        if statuses.any?
          print_statuses(statuses)
        else
          say "No mentions of @#{username}"
        end
      end
    end
  end
end
