# Barr

Barr is a status line generator for Lemonbar. It is an alternative to the common method of using shell scripts to generate the bar's content. Barr is written in, and configured with, Ruby.

Barr aims to make creating and maintaining Lemonbar scripts much easier. At its core is a suite of re-usable and configurable Blocks. These blocks can be added to your bar as-is; configured to your liking; or extended to create your own behaviour. This allows status lines to be created in a more declarative manner. 

## Installation

    $ gem install barr

If that doesn't work, you probably don't have Ruby installed. I'd recommend you install it via [RVM](http://rvm.io) or [rbenv](https://github.com/rbenv/rbenv), though they're probably overkill if you don't already use Ruby regularly.

For a simpler install, check your distro's package manager. That should be fine.

## Usage

See [Examples folder](http://github.com/okaydave/barr/tree/master/examples) for more detailed usage examples.

Documentation about all available blocks and their options can be found further down in this document.

### Simple Usage Example 

*barr_example.rb*
```ruby
 #!/usr/bin/env ruby

 # pull in the Barr gem
 require 'rubygems'
 require 'barr'

 # Create a new manager instance.
 # The manager is responsible for organising the blocks and delivering their output to lemonbar
 @manager = Barr::Manager.new

 # Add a 'WhoAmI' block. This just outputs logged in username
 # Give it a peach background, grey text and updates every 10000 seconds
 # It will be aligned to the left of the bar
 @manager.add_block Barr::Blocks::WhoAmI.new(bcolor: "#FFAAAA", fcolor: "#333333", interval: 10000)

 # Add a 'Clock' block.
 # Clocks can be formatted in the type strftime fashion. This example outputs the current Hour and Minute
 # It will update every second.
 # By default, the background text colour will be deferred to the Lemonbar config
 # If FontAwesome font is available to lemonbar, it will be prepended with a clock icon.
 @manager.add_block Barr::Blocks::Clock.new(icon: "\uf017", format: "%H:%M", align: :c, interval: 1)


 # Add a 'Cpu' block. This shows the current CPU usage (averaged across all cores if present)
 # It will be aligned to the right side of of the bar
 # As an interval is not provided, it will update every 5 seconds.
 # It will be prepended with the text 'Cpu:'
 @manager.add_block Barr::Blocks::Cpu.new(icon: "Cpu:", align: :r)


 # Tell the manager to run the loop. This will continue indefinitely, outputing the data ready to be piped in to lemonbar.
 @manager.run
```

This can be piped in to lemonbar as usual:

```bash
#!/bin/bash

./barr_example.rb | lemonbar -g 800x30+960+00 -d -B "#333333" -f "Roboto Mono Medium:size=11" -f "Font Awesome:size=11" | sh
```

Which should have Lemonbar appear as: 

![simple example](http://i.imgur.com/r4dtoqm.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OkayDave/barr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

