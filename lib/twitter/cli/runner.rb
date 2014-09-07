module Twitter
  module Cli
    class Runner < Thor
      desc 'start', 'Runs the gem through workflow'
      def start
        greet
        consumer_key, consumer_secret = ask_for_consumer_credentials
        say 'We are getting the access token...', :blue
        @twitter_service = Twitter::Cli::TwitterService.new(consumer_key, consumer_secret)
        while (@twitter_service.access_token)
          say 'Which feature would you like to use:', :blue
          say '1. Find mentions of the user', :yellow
          say '2. Exit the program', :yellow
          choice = ask 'Please write the number of the choice:', limited_to: %w(1 2), color: :yellow
          if choice == '1'
            find_mentions
          elsif choice == '2'
            say 'Bye...', :red
            break
          end
        end
        say 'We could not get an access token with the provided consumer key and secret', :red unless @twitter_service.access_token
      end

      desc 'greet', 'Greets the user'
      def greet
        say "Hello! Let\'s access Twitter API to get information", :blue
        say 'For this you will need to obtain consumer key and secret from https://apps.twitter.com/', :blue
      end

      desc 'ask_for_consumer_credentials', 'Asks for Twitter API credentials'
      def ask_for_consumer_credentials
        consumer_key    = ask 'Please input your consumer key:', :yellow
        consumer_secret = ask 'Please input your secret:', :yellow
        [consumer_key, consumer_secret]
      end

      desc 'print_statuses STATUSES', 'Prints tweets'
      def print_statuses(statuses)
        statuses.each do |status|
          say "@#{status[:username]} said:  ", :magenta
          say "#{status[:text]}", :green
        end
      end

      desc 'find_mentions', 'Asks for a username and looks for mentions'
      def find_mentions
        username = ''
        while username.empty?
          username = ask 'Search for the latest 3 user mentions. Please enter any username (without @):', :yellow
        end
        say '====='
        statuses = @twitter_service.mentions(username)
        if statuses.any?
          print_statuses(statuses)
        else
          say "No mentions of @#{username}", :red
        end
      end
    end
  end
end
