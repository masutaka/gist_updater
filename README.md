# GistUpdater

[![Travis Status](https://img.shields.io/travis/masutaka/gist_updater.svg?style=flat-square)][travisci]
[![License](https://img.shields.io/github/license/masutaka/gist_updater.svg?style=flat-square)][license]
[![Gem](https://img.shields.io/gem/v/gist_updater.svg?style=flat-square)][gem-link]

[travisci]: https://travis-ci.org/masutaka/gist_updater
[license]: https://github.com/masutaka/gist_updater/blob/master/LICENSE.txt
[gem-link]: http://badge.fury.io/rb/gist_updater

## Description

Updates your Gist files defined in YAML

https://masutaka.net/chalow/2016-09-29-1.html (In Japanese)

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
#=> Array<Sawyer::Resource>
```

## YAML format

```yaml
-
  - 'gist_id_1'
  - 'path to file_1'
-
  - 'gist_id_2'
  - 'path to file_2a'
  - 'path to file_2b'
```

For example,

```yaml
-
  # https://gist.github.com/masutaka/8177244
  - 8177244
  - .emacs.d/init.el
-
  # https://gist.github.com/masutaka/f7ce8b3c71e995c20e48
  - f7ce8b3c71e995c20e48
  - circle.yml
  - tasks/pushover.rake
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masutaka/gist_updater. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
