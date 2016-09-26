# frozen_string_literal: true

require 'yaml'

module GistUpdater
  class Config
    def initialize(file)
      @file = file
    end

    def each
      return enum_for(:each) unless block_given?

      config.each do |gist_id, file_name|
        yield(gist_id, file_name)
      end
    end

    private

    attr_reader :file

    def config
      @config ||= YAML.load(IO.read(file))
    end
  end
end
