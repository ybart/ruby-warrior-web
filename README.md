# Ruby Warrior Web

A Web version of the Ruby warrior gem by Ryan Bates, inspired by the done on bloc.io by Emelyn Baker, Christian Schlensker and Roshan Choxi.

## Requirements

- Ruby
- Bundler

## Getting Started

To play the game, you need to clone this directory, build the game,
and run a simple static server.

First, we need to get the project repository locally:

```
git clone https://github.com/ybart/ruby-warrior-web.git
cd ruby-warrior-web
```

Then, we install project dependencies using bundler:

```
bin/setup
```

We convert the Ruby code JS to run it in our browser:

```
rake opal:build
```

Then, we run the web server:

```
bin/server
```

We can then access it using the foloowing URL:

http://localhost:4567

## TODO List

- Create a command that would be available after a rubygems install, that will build and serve the project automatically.
- Host the latest built version on GitHub Pages.
- Remove Google Fonts from the repository

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ybart/ruby-warrior-web. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ruby-warrior-web/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the RubyWarriorWeb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ybart/ruby-warrior-web/blob/master/CODE_OF_CONDUCT.md).
