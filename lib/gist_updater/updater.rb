# frozen_string_literal: true

module GistUpdater
  class Updater
    def initialize(options, config_class = Config)
      @user             = options[:user] || ENV['GISTUPDATER_USER']
      @access_token     = options[:token] || ENV['GISTUPDATER_ACCESS_TOKEN']
      GistUpdater.debug = options[:debug]
      @config           = config_class.new(options[:yaml])
    end

    def update
      config.each do |gist_id, file_name|
        Content.new(
          user: user,
          access_token: access_token,
          gist_id: gist_id,
          file_name: file_name
        ).update_if_need
      end
    end

    private

    attr_reader :user, :access_token, :config
  end
end
