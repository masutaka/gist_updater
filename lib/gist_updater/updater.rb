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
      config.each do |c|
        content = ContentFactory.build(user, access_token, c)

        if content.gist == content.local
          puts <<~EOS if debug
            There was no need to update `#{content.name}`.
          EOS
        else
          content.update
        end
      end
    end

    private

    attr_reader :user, :access_token, :debug, :config
  end
end
