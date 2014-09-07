module Twitter
  module Cli
    class Runner < Thor::Shell::Basic
      def run
        say 'Hello! Let\'s access Twitter API to get information'
        say 'For this you will need to obtain consumer key and secret from https://apps.twitter.com/'
        consumer_key    = ask('Please input your consumer key:')
        consumer_secret = ask('Please input your secret:')
        say 'We are getting the access token...'
        twitter_service = Twitter::Cli::TwitterService.new(consumer_key, consumer_secret)
        while (twitter_service.access_token)
          username = ask('Search for the latest 3 user mentions. Please enter any username (without @):')
          next if username.empty?
          say '====='
          statuses = twitter_service.mentions(username)
          if statuses.any?
            statuses.each do |status|
              say "@#{status[:username]} said:  "
              say "#{status[:text]}"
            end
          else
            say "No mentions of @#{username}"
          end
        end
        say 'We could not get an access token with the provided consumer key and secret' unless twitter_service.access_token
      end
    end
  end
end
