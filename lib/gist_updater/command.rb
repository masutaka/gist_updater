require 'thor'

require 'yaml'

module GistUpdater
  class Command < Thor
    package_name 'gist_updater'
    default_task :update
    class_option :yaml, type: :string,
                 default: 'gist_updater.yml',
                 aliases: :y, desc: 'User definition YAML file'

    desc 'update', 'Update your Gist files (default)'
    def update
      config.each do |c|
        content = Content.new(c['gist_id'], c['file_name'])
        content.update unless content.gist == content.local
      end
    end

    private

    def config
      @config ||= YAML.load(IO.read(options[:yaml]))
    end
  end
end
