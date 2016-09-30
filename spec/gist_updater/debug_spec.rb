# frozen_string_literal: true

describe GistUpdater do
  describe '.debug' do
    it { is_expected.to respond_to :debug }
    it { is_expected.to respond_to :debug= }
  end
end
