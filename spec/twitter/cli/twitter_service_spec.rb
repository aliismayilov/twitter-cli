require 'spec_helper'

describe Twitter::Cli::TwitterService do
  describe 'config' do
    subject { Twitter::Cli::TwitterService }
    its(:base_uri) { is_expected.to eql 'https://api.twitter.com/1.1' }
    its(:format)   { is_expected.to eql :json }
  end
end
