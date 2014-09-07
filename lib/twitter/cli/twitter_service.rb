module Twitter
  module Cli
    class TwitterService
      include HTTParty
      base_uri 'https://api.twitter.com/1.1'
      format :json
    end
  end
end
