# frozen_string_literal: true

require 'yaml'

module GistUpdater
  class Config
    # @param file [String] a YAML file path
    def initialize(file)
      @file = file
    end

    # Calls block once for each element in config
    #
    # @yield [gist_id:, file_paths:] Gist file paths
    # @yieldparam gist_id [String] a Gist id
    # @yieldparam file_paths [Array<String>] file paths
    # @yieldreturn [Array]
    # @return [Enumerator]
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
