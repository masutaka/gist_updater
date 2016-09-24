module GistUpdater
  class Command
    def initialize(config)
      @config = config
    end

    def run
      config.each do |c|
        content = Content.new(c['gist_id'], c['file_name'])
        content.update unless content.gist == content.local
      end
    end

    private

    attr_reader :config
  end
end
