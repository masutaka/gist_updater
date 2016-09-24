# frozen_string_literal: true

require 'thor'
require 'yaml'

module GistUpdater
  # Provide command
  class Commands < Thor
    package_name 'gist_updater'
    default_task :update
    class_option :yaml, type: :string, aliases: :y,
                        desc: 'User definition YAML file',
                        default: 'gist_updater.yml'
    class_option :user, type: :string, aliases: :u,
                        desc: 'GitHub username'
    class_option :token, type: :string, aliases: :t,
                         desc: 'GitHub personal access token'
    class_option :debug, type: :boolean, aliases: :d,
                         desc: 'Debug mode', default: false

    desc 'update', 'Update your Gist files (default)'
    def update
      configs.each do |config|
        content = ContentFactory.build(user, access_token, config)

        if content.gist == content.local
          puts <<~EOS if options[:debug]
            There was no need to update `#{content.name}`.
          EOS
        else
          content.update
        end
      end
    end

    desc 'version', 'Display version'
    def version
      puts VERSION
    end

    private

    def configs
      @configs ||= YAML.load(IO.read(options[:yaml]))
    end

    def user
      @user ||= options[:user] ||
                ENV['GISTUPDATER_USER'] ||
                help_and_exit
    end

    def access_token
      @access_token ||= options[:token] ||
                        ENV['GISTUPDATER_ACCESS_TOKEN'] ||
                        help_and_exit
    end

    def help_and_exit
      help
      exit(1)
    end
  end
end
