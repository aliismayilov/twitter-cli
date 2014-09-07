require 'spec_helper'

describe Twitter::Cli do
  it 'has a version number' do
    expect(Twitter::Cli::VERSION).not_to be nil
  end
end
