# frozen_string_literal: true

require 'octokit'

module GistUpdater
  class Content
    def initialize(user:, access_token:, gist_id:, file_path:)
      @user         = user
      @access_token = access_token
      @gist_id      = gist_id
      @file_path    = file_path
    end

    def update_if_need
      if gist == local
        puts "There was no need to update `#{file_path}`." if GistUpdater.debug
      else
        puts "Updated `#{file_path}` to #{update.html_url}"
      end
    end

    private

    attr_reader :user, :access_token, :gist_id, :file_path

    def client
      @client ||= Octokit::Client.new(login: user, access_token: access_token)
    end

    def gist
      @gist ||= client.gist(gist_id).files[file_name].content
    end

    def local
      @local ||= File.read(file_path)
    end

    def update
      client.edit_gist(
        gist_id,
        files: { file_name => { 'content' => local } }
      )
    end

    def file_name
      @file_name ||= File.basename(file_path)
    end
  end
end
