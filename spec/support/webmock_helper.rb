# frozen_string_literal: true

module WebmockHelper
  def stub_request_get_200(uri, response_body)
    WebMock.stub_request(:get, uri).to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json; charset=utf-8' },
      body: response_body
    )
  end

  def stub_request_patch_200(uri, response_body)
    WebMock.stub_request(:patch, uri).to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json; charset=utf-8' },
      body: response_body
    )
  end
end
