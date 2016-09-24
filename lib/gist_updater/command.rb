# frozen_string_literal: true

require 'thor'
require 'yaml'

module GistUpdater
  # Provide command
  class Command < Thor
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
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def update
      config.each do |c|
        content = Content.new(
          user: user,
          access_token: access_token,
          gist_id: c['gist_id'],
          file_name: c['file_name']
        )

        if content.gist == content.local
          puts <<~EOS if options[:debug]
            There was no need to update `#{c['file_name']}`.
          EOS
        else
          content.update
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    desc 'version', 'Display version'
    def version
      puts VERSION
    end

    private

    def config
      @config ||= YAML.load(IO.read(options[:yaml]))
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
