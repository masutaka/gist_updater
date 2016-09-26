# GistUpdater

[![Build Status](https://img.shields.io/circleci/project/masutaka/gist_updater/master.svg?maxAge=2592000?style=flat-square)][circleci]
[![License](https://img.shields.io/github/license/masutaka/gist_updater.svg?maxAge=2592000?style=flat-square)][license]
[![Gem](https://img.shields.io/gem/v/gist_updater.svg?maxAge=2592000?style=flat-square)][gem-link]

[circleci]: https://circleci.com/gh/masutaka/gist_updater
[license]: https://github.com/masutaka/gist_updater/blob/master/LICENSE.txt
[gem-link]: http://badge.fury.io/rb/gist_updater

## Description

Updates your Gist files which are defined in YAML

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gist_updater'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gist_updater

## Usage

### CLI

```
gist_updater commands:
  gist_updater help [COMMAND]  # Describe available commands or one specific command
  gist_updater update          # Update your Gist files (default)
  gist_updater version         # Display version

Options:
  y, [--yaml=YAML]            # User definition YAML file
                              # Default: gist_updater.yml
  u, [--user=USER]            # GitHub username
  t, [--token=TOKEN]          # GitHub personal access token
  d, [--debug], [--no-debug]  # Debug mode
```

### Script

```ruby
require 'gist_updater'

GistUpdater::Updater.new(
  yaml:  'User definition YAML file',
  user:  'GitHub usename',               # or $GISTUPDATER_USER
  token: 'GitHub personal access token', # or $GISTUPDATER_ACCESS_TOKEN
  debug: 'true or false'
).update
#=> update count
```

## YAML format

```yaml
-
  - 'gist_id1'
  - 'path to file1'
-
  - 'gist_id2'
  - 'path to file2'
```

For example,

```yaml
-
  # https://gist.github.com/masutaka/8177244
  - 8177244
  - .emacs.d/init.el
-
  # https://gist.github.com/masutaka/9642146
  - 9642146
  - bin/my-brew-bundle
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masutaka/gist_updater. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
