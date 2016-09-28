# frozen_string_literal: true

module GistUpdater
  class Updater
    def initialize(options, config_class = Config)
      @user             = options[:user] || ENV['GISTUPDATER_USER']
      @access_token     = options[:token] || ENV['GISTUPDATER_ACCESS_TOKEN']
      @config           = config_class.new(options[:yaml])
      GistUpdater.debug = options[:debug]
    end

    def update
      count = 0

      config.each do |gist_id:, file_paths:|
        file_paths.each do |file_path|
          count += 1 if update_by_gist(gist_id, file_path)
        end
      end

      count
    end

    private

    attr_reader :user, :access_token, :config

    def update_by_gist(id, file_path)
      Content.new(
        user: user,
        access_token: access_token,
        gist_id: id,
        file_path: file_path
      ).update_if_need
    end
  end
end
