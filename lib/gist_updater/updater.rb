# frozen_string_literal: true

module GistUpdater
  class Updater
    def initialize(options, config_class = Config)
      @user = options[:user] || ENV['GISTUPDATER_USER']
      @access_token = options[:access_token] || ENV['GISTUPDATER_ACCESS_TOKEN']
      @debug = options[:debug]
      @config = config_class.new(options[:yaml])
    end

    def update
      config.each do |gist_id, file_name|
        Content.new(
          user: user,
          access_token: access_token,
          gist_id: gist_id,
          file_name: file_name,
          debug: debug
        ).update_if_need
      end
    end

    private

    attr_reader :user, :access_token, :debug, :config
  end
end
