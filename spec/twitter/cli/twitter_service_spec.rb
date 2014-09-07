require 'spec_helper'

describe Twitter::Cli::TwitterService do
  describe 'config' do
    subject { Twitter::Cli::TwitterService }
    its(:base_uri) { is_expected.to eql 'https://api.twitter.com' }
    its(:format)   { is_expected.to eql :json }
  end

  describe 'getting access token' do
    subject(:twitter_service) { Twitter::Cli::TwitterService.new('xvz1evFS4wEEPTGEFPHBog', 'L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg') }

    it 'encodes consumer key and secret in base64 format' do
      expect(twitter_service.base64_credentials).to eql 'eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw=='
    end
  end
end
