$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'twitter/cli'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

def spec_path
  File.dirname(__FILE__)
end
