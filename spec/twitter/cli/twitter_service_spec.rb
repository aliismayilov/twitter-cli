require 'spec_helper'

describe Twitter::Cli::TwitterService do
  describe 'config' do
    subject { Twitter::Cli::TwitterService }
    its(:base_uri) { is_expected.to eql 'https://api.twitter.com' }
    its(:format)   { is_expected.to eql :json }
  end

  describe 'getting access token' do
    let(:twitter_service) { Twitter::Cli::TwitterService.new('xvz1evFS4wEEPTGEFPHBog', 'L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg') }

    it 'encodes consumer key and secret in base64 format' do
      expect(twitter_service.base64_credentials).to eql 'eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw=='
    end

    it 'posts consumer credentials to get the access_token' do
      allow(Twitter::Cli::TwitterService).to receive(:post) do
        double('response', body: '{"token_type":"bearer","access_token":"AAAA%2FAAA%3DAAAAAAAA"}')
      end
      expect(twitter_service.access_token).to eql 'AAAA%2FAAA%3DAAAAAAAA'
    end
  end
end
