# frozen_string_literal: true

describe GistUpdater::Commands do
  it { is_expected.to respond_to :update }
  it { is_expected.to respond_to :version }
end
