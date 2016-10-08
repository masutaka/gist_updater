# frozen_string_literal: true

shared_examples 'ConfigInterface' do
  subject { described_class.new('dummy.yml') }
  it { is_expected.to respond_to :each }
end
