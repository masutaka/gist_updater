# frozen_string_literal: true

require 'octokit'

module GistUpdater
  class Content
    attr_reader :name

    def initialize(user:, access_token:, gist_id:, file_name:)
      @client = Octokit::Client.new(
        login:        user,
        access_token: access_token
      )
      @gist_id  = gist_id
      @name     = file_name
      @basename = File.basename(file_name)
    end

    def gist
      @gist ||= client.gist(gist_id).files[basename].content
    end

    def local
      @local ||= File.read(name)
    end

    def update
      result = client.edit_gist(
        gist_id,
        files: { basename => { 'content' => local } }
      )
      puts "Updated `#{name}` to #{result.html_url}"
      result
    end

    private

    attr_reader :client, :gist_id, :basename
  end
end
