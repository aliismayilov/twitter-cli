require 'spec_helper'

describe Twitter::Cli::TwitterService do
  describe 'config' do
    subject { Twitter::Cli::TwitterService }
    its(:base_uri) { is_expected.to eql 'https://api.twitter.com' }
    its(:format)   { is_expected.to eql :json }
  end

  describe 'getting access token', :vcr do
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

  describe '#mentions' do
    let(:twitter_service) { Twitter::Cli::TwitterService.new('consumer_key', 'consumer_secret') }
    let(:mentions_search_json_file) { File.join(spec_path, 'fixtures', 'mentions', 'search.json') }

    before do
      allow(Twitter::Cli::TwitterService).to receive(:post) do
        double('response', body: '{"token_type":"bearer","access_token":"AAAA%2FAAA%3DAAAAAAAA"}')
      end

      allow(Twitter::Cli::TwitterService).to receive(:get) do
        double('response', body: File.read(mentions_search_json_file))
      end
    end

    it 'gets last 3 tweets where the specified user is mentioned' do
      expect(twitter_service.mentions('qaralama')).to have(3).tweets
    end

    it 'maps statuses as {:username, :text} hashes' do
      expect(twitter_service.mentions('qaralama').first).to eql({
        username: 'Familm',
        text: 'Skill Mash website is going to be online soon. Thanks for your hard work @qaralama Countdow starts...:)'
      })
    end
  end
end
