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


## Block Configuration 

### Common

All blocks inherit their behaviour from a base Block. This means that all blocks will respond to the following configuration options:

| Option | Value | Description | Default |
| ------ | ----- | ----------- |
| `fcolor` | RGB Hex string or `-` | Equivalent to lemonbar's `%{F}` format. Takes a hex string in the format of `#FFF`, `#FFFFFF`, or '#FFFFFFFF' (for transparency). | `"-"`
| `bcolor` | RGB Hex string or `-` | As above. To use the configured lemonbar colors, use `"-"`. This also applies to the `fcolor` option. | `"-"`
| `icon`   | String | This is prepended to each blocks' output. It can be a normal string like `"CPU:"` or a unicode string like `"\uf164"` (thumbs up in Font Awesome | `""`
| `interval` | Integer | How frequently the Block should perform its update method in seconds. The block is drawn to lemonbar every second, this just affects how frequently the data can change.  | `5`
| `align` | Symbol | One of `:l`, `:c`, `:r` for left, centre and right alignment respectively. | `:l`
 
 These are set when a Block is initialized:
 
 ```ruby 
 @man = Barr::Manager.new 
 
 @block = Barr::Block.new fcolor: "#FF0000",
                          bcolor: "#000000",
                          icon:   "Sample:",
                          interval: 10, 
                          align: :r

@man.add_block @block
  
 ```
 
 
 
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OkayDave/barr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

I'd love to see PRs for more blocks. If you do make any, please ensure that you've added their config options to this README and that you've written some specs for it (including stubbing / mocking out any system and/or API calls it makes). 

If there's a block you'd like to see, but don't have the time, knowledge, or desire to make one then please do open a request on the [Issue Tracker](https://github.com/OkayDave/barr/issues).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

