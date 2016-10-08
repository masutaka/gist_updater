# frozen_string_literal: true

describe GistUpdater::Config do
  describe '#each' do
    let(:config) { GistUpdater::Config.new(file) }

    context 'given 1 content' do
      let(:file) { 'spec/fixtures/test-one-content.yml' }

      it 'is valid yield control' do
        expect { |b| config.each(&b) }.to yield_control.once
      end

      it 'is valid yield args' do
        expect do |b|
          config.each(&b)
        end.to yield_successive_args(
          gist_id: 'b583a2edf21c62fae3146f7231df5bea',
          file_paths: ['spec/fixtures/hoge.txt']
        )
      end
    end

    context 'given 2 contents' do
      let(:file) { 'spec/fixtures/test-two-contents.yml' }

      it 'is valid yield control' do
        expect { |b| config.each(&b) }.to yield_control.twice
      end

      it 'is valid yield args' do
        expect do |b|
          config.each(&b)
        end.to yield_successive_args(
          # rubocop:disable Style/BracesAroundHashParameters
          {
            gist_id: 'b583a2edf21c62fae3146f7231df5bea',
            file_paths: ['spec/fixtures/hoge.txt']
          },
          {
            gist_id: 'b0626b844c24c3e442004da06bca22d4',
            file_paths: ['spec/fixtures/hogehoge.txt']
          }
          # rubocop:enable Style/BracesAroundHashParameters
        )
      end
    end
  end
end
