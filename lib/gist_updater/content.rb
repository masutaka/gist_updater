# frozen_string_literal: true

require 'octokit'

module GistUpdater
  # A content related to a gist file
  class Content
    # @param user [String] GitHub username
    # @param access_token [String] GitHub personal access token
    # @param gist_id [String] A gist id
    # @param file_path [String] A relative file path
    def initialize(user:, access_token:, gist_id:, file_path:)
      @user         = user
      @access_token = access_token
      @gist_id      = gist_id
      @file_path    = file_path
    end

    # Update the content if needed
    #
    # @return [Sawyer::Resource] an updated resource
    # @return [NilClass] isnot updated
    def update_if_need
      if need_to_update?
        resource = update
        puts "Updated `#{file_path}` to #{resource.html_url}"
      elsif GistUpdater.debug
        puts "There is no update for `#{file_path}`."
      end

      pick_a_file(resource)
    end

    private

    attr_reader :user, :access_token, :gist_id, :file_path

    def client
      @client ||= Octokit::Client.new(login: user, access_token: access_token)
    end

    def need_to_update?
      @need_to_update ||= gist != local
    end

    def gist
      @gist ||= client.gist(gist_id).files[file_name].content
    end

    def local
      @local ||= File.read(file_path)
    end

    def pick_a_file(resource)
      resource&.files&.file_name
    end

    # Update a Gist file
    #
    # @return [Sawyer::Resource]
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
