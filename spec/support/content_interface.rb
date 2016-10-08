# frozen_string_literal: true

shared_examples 'ContentInterface' do
  subject do
    described_class.new(
      user: nil,
      access_token: nil,
      gist_id: nil,
      file_path: nil
    )
  end

  it { is_expected.to respond_to :update_if_need }
end
