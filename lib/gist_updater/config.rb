# frozen_string_literal: true

require 'yaml'

module GistUpdater
  class Config
    def initialize(file)
      @file = file
    end

    def each
      return enum_for(:each) unless block_given?

      config.each do |c|
        yield(gist_id: c.first, file_paths: c.drop(1))
      end
    end

    private

    attr_reader :file

    def config
      @config ||= YAML.load(IO.read(file))
    end
  end
end
