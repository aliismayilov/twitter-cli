require 'spec_helper'

describe Twitter::Cli::Runner do
  describe 'thor' do
    subject { Twitter::Cli::Runner.new }
    it { is_expected.to be_a Thor }
  end
end
