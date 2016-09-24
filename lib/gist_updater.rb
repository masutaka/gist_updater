require "gist_updater/command"
require "gist_updater/content"
require "gist_updater/version"

require 'yaml'

GistUpdater::Command.new(
  YAML.load(IO.read('gist_updater.yml'))
).run
