require 'thor'

require 'yaml'

module GistUpdater
  class Command < Thor
    package_name 'gist_updater'
    default_task :update
    class_option :yaml, type: :string,
                 default: 'gist_updater.yml',
                 aliases: :y, desc: 'User definition YAML file'
    class_option :user, type: :string,
                 aliases: :u, desc: 'GitHub username'
    class_option :token, type: :string,
                 aliases: :t, desc: 'GitHub personal access token'

    desc 'update', 'Update your Gist files (default)'
    def update
      config.each do |c|
        content = Content.new(
          user: user,
          access_token: access_token,
          gist_id: c['gist_id'],
          file_name: c['file_name']
        )
        content.update unless content.gist == content.local
      end
    end

    private

    def config
      @config ||= YAML.load(IO.read(options[:yaml]))
    end

    def user
      @user ||= options[:user] || ENV['GISTUPDATER_USER']
    end

    def access_token
      @access_token ||= options[:token] || ENV['GISTUPDATER_ACCESS_TOKEN']
    end
  end
end
