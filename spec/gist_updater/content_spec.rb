# frozen_string_literal: true

describe GistUpdater::Content do
  it_behaves_like 'ContentInterface'

  describe '#update_if_need' do
    let(:content) do
      GistUpdater::Content.new(
        user: 'masutaka',
        access_token: '01234abcd',
        gist_id: gist_id,
        file_path: file_path
      )
    end

    context 'given same content to gist' do
      let(:gist_id) { 'b583a2edf21c62fae3146f7231df5bea' }
      let(:file_path) { 'spec/fixtures/hoge.txt' }

      before do
        stub_request_get_200("https://api.github.com/gists/#{gist_id}",
                             fixture('get_a_single_gist_hoge.json'))
      end

      context 'given normal mode' do
        before { GistUpdater.debug = false }

        it 'is nil' do
          expect(content.update_if_need).to be_nil
        end

        it "doesn't output to stdout" do
          expect { content.update_if_need }.to_not output.to_stdout
        end
      end

      context 'given debug mode' do
        let(:valid_output) do
          "There is no update for `#{file_path}`.\n"
        end

        before { GistUpdater.debug = true }

        it 'is nil' do
          expect(content.update_if_need).to be_nil
        end

        it 'outputs to stdout' do
          expect { content.update_if_need }.to output(valid_output).to_stdout
        end
      end
    end

    context 'given different content to gist' do
      let(:gist_id) { 'b0626b844c24c3e442004da06bca22d4' }
      let(:file_path) { 'spec/fixtures/hogehoge.txt' }

      before do
        stub_request_get_200("https://api.github.com/gists/#{gist_id}",
                             fixture('get_a_single_gist_hogehoge.json'))
        stub_request_patch_200("https://api.github.com/gists/#{gist_id}",
                               fixture('patch_a_gist_hogehoge.json'))
      end

      context 'given normal mode' do
        let(:valid_output) do
          "Updated `#{file_path}` to https://gist.github.com/#{gist_id}\n"
        end

        before { GistUpdater.debug = false }

        it 'is same filename' do
          expect(content.update_if_need.filename).to eq 'hogehoge.txt'
        end

        it 'outputs to stdout' do
          expect { content.update_if_need }.to output(valid_output).to_stdout
        end
      end

      context 'given debug mode' do
        let(:valid_output) do
          "Updated `#{file_path}` to https://gist.github.com/#{gist_id}\n"
        end

        before { GistUpdater.debug = true }

        it 'is same filename' do
          expect(content.update_if_need.filename).to eq 'hogehoge.txt'
        end

        it 'outputs to stdout' do
          expect { content.update_if_need }.to output(valid_output).to_stdout
        end
      end
    end
  end
end
