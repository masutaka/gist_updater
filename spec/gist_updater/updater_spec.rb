# frozen_string_literal: true

class ConfigDouble
  def initialize(file)
  end

  def each
    yield(gist_id: '12345678', file_paths: %w(aaa.txt bbb.txt))
  end
end

class ContentDouble
  def initialize(user:, access_token:, gist_id:, file_path:)
  end

  def update_if_need
    nil
  end
end

describe ConfigDouble do
  it_behaves_like 'ConfigInterface'
end

describe ContentDouble do
  it_behaves_like 'ContentInterface'
end

describe GistUpdater::Updater do
  describe '#update' do
    let(:updater) do
      GistUpdater::Updater.new(
        {
          user: 'masutaka',
          token: 'token01234',
          yaml: 'dummy.yml'
        },
        ConfigDouble
      )
    end

    subject { updater.update(ContentDouble) }
    it { is_expected.to be_empty }
  end
end
