# Barr

![Barr](http://i.imgur.com/uSereZl.png)

Barr is a status line generator for Lemonbar. It is an alternative to the common method of using shell scripts to generate the bar's content. Barr is written in, and configured with, Ruby.

Barr aims to make creating and maintaining Lemonbar scripts much easier. At its core is a suite of re-usable and configurable Blocks. These blocks can be added to your bar as-is; configured to your liking; or extended to create your own behaviour. This allows status lines to be created in a more declarative manner.

## Installation

    $ gem install barr

If that doesn't work, you probably don't have Ruby installed. I'd recommend you install it via [RVM](http://rvm.io) or [rbenv](https://github.com/rbenv/rbenv), though they're probably overkill if you don't already use Ruby regularly.

For a simpler install, check your distro's package manager. That should be fine.

To update to the latest release of Barr:

    $ gem update barr

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

# Add a 'Whoami' block. This just outputs logged in username
# Give it a peach background, grey text and updates every 10000 seconds
# It will be aligned to the left of the bar
@manager.add Barr::Blocks::Whoami.new(bgcolor: '#FFAAAA', fgcolor: '#333333', interval: 10000)

# Add a 'Clock' block.
# Clocks can be formatted in the type strftime fashion. This example outputs the current Hour and Minute
# It will update every second.
# By default, the background text colour will be deferred to the Lemonbar config
# If FontAwesome font is available to lemonbar, it will be prepended with a clock icon.
@manager.add Barr::Blocks::Clock.new(icon: "\uf017", format: '%H:%M', align: :c, interval: 1)


# Add a 'CPU' block. This shows the current CPU usage (averaged across all cores if present)
# It will be aligned to the right side of of the bar
# As an interval is not provided, it will update every 5 seconds.
# It will be prepended with the text 'Cpu:'
@manager.add Barr::Blocks::CPU.new(icon: 'Cpu:', align: :r)


# Tell the manager to run the loop. This will continue indefinitely, outputing the data ready to be piped in to lemonbar.
@manager.run!
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
| ------ | ----- | ----------- | ------- |
| `fgcolor` | RGB Hex string or `-` | Equivalent to lemonbar's `%{F}` format. Takes a hex string in the format of `#FFF`, `#FFFFFF`, or `#FFFFFFFF` (for transparency). | `'-'` |
| `bgcolor` | RGB Hex string or `-` | As above. To use the configured lemonbar colors, use `'-'`. This also applies to the `fgcolor` option. | `'-'` |
| `icon`   | String | This is prepended to each blocks' data. It can be a normal string like `'CPU:'` or a unicode string like `"\uf164"` (thumbs up in Font Awesome) | `''` |
| `interval` | Integer | How frequently the Block should perform its `update!` method in seconds. The block is drawn to lemonbar every second, this just affects how frequently the data can change.  | `5` |
| `align` | Symbol | One of `:l`, `:c`, `:r` for left, centre and right alignment respectively. | `:l` |

These are set when a Block is initialized:

```ruby
@man = Barr::Manager.new

block1 = Barr::Block.new fgcolor: '#FF0000',
                         bgcolor: '#000000',
                         icon:   'I am:',
                         interval: 10,
                         align: :r

man.add block1

```

If you're unfamiliar with Ruby here's a couple of tips that might help with reading and writing your own blocks:

* Parentheses are optional most of the time. The exception is when their absense causes ambiguity as to which arguments belong to which methods.
* The arguments to `Barr::Block.new` are supplied as a `Hash`. This means that you don't need to put them in a specific order.
* If you want to use a default value, you can just omit the option altogether.
* Whitespace isn't that important, at least compared to languages like Python. Feel free to use whitespace to make your code more readable.

For example, the following code:

```ruby
@man = Barr::Manager.new()

block1 = Barr::Blocks::Whoami.new({fgcolor: '#FFF', bgcolor: '#000', align: :c})

@man.add(block1)

```

Is functionally the same as this:

```ruby
@man = Barr::Manager.new

block1 = Barr::Blocks::Whoami.new align: :c,
                                  fgcolor: '#FFF',
                                  bgcolor: '#000'

@man.add block1

```

You can also add Blocks straight to the manager if you'd like to skip that step, or even mix/match:

```ruby
@man = Barr::Manager.new

seperate_block = Barr::Blocks::Whoami.new

@man.add Barr::Blocks::Whoami.new bgcolor: '#000', fgcolor: '#FFF'
@man.add(Barr::Blocks::Whoami.new(icon: 'Me!', align: :c))
@man.add separate_block
```


### Block Specific Configuration

#### Battery

Show battery status.

`battery = Barr::Blocks::Battery.new show_remaining: true`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `show_remaining` | bool | Show the remaining battery time | `true` |

#### BBCWeather 

Shows configurable weather information as provided by the BBC. Recommended over the `Temperature` block due to how much more reliable the BBC service is.

`bbc = Barr::Blocks::BBCWeather.new location: "5308655", format: "${TEMPERATURE} wind: ${WINDSPEED} ${WINDDIRECTION}"

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `format` | string | Configurable format for showing which weather information is displayed. See table below for options. | `"${TEMPERATURE} - ${SUMMARY}"` |
| `location` | string | Find your location on the [BBC Weather](http://www.bbc.co.uk/weather) service and use the last part of the URL as the location string. For example, Phoenix Arizona is "5308655". | **REQUIRED** |
| `speed_unit` | "mph" or "kph" | Whether to show speeds in mph or kph | `"mph"`
| `temp_unit` | "c" or "f" | Whether to show temperatures in C or F | `"c"`

| Option | Description | 
| --- | --- | 
| `${TEMPERATURE}` | Current temperature | 
| `${SUMMARY}` | Brief summary of weather, e.g. "Light cloud" | 
| `${WINDSPEED}` | Current wind speed | 
| `${WINDDIRECTION}` | Current wind direction | 
| `${HUMIDITY}` | Current humidity percentage | 
| `${VISIBILITY}` | Sumamry of visbility, e.g. "Excellent" | 
| `${PRESSURE}` | Current pressure and trend, e.g. "1000mb, Falling" |
 
#### Bspwm (Experimental)

**Requires Bspwm**. Shows desktops for selected monitor. and highlights focused one. Unfocused desktops are clickable. Could do with some optimization work and feedback from people that use BSP frequently, especially with multiple monitors. 

`bsp = Barr::Blocks::Bspwm.new monitor: "DP-4", invert_focus_colors: true` 

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `focus_markers` | 2 element Array | These are used to 'highlight' the active workspace. The first element is used on the left of the active workspace, the second element on the right. | `['>', '<']` |
| `invert_focus_colors` | bool | Should the block's `fgcolor` and `bgcolor` attributes be reversed for the workspace that is currently focused. | `false` |
| `monitor` | String | The monitor ID (e.g. from `xrandr`) that the bar should read the desktops from. | First monitor found |

#### Clock

Shows the current date and/or time.

`clock = Barr::Blocks::Clock.new format: '%m %b %Y', icon: 'Date: '`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `format` | strftime String | This takes a [strftime](http://ruby-doc.org/core-2.2.0/Time.html#method-i-strftime) formatted string. If you're not familiar with this syntax, you could use an [online generator](http://www.foragoodstrftime.com/).  | `'%H:%M %m %b %Y'` |


#### Conky (Experimental)

**Requires Conky**.  Show a conky `TEXT` formatted output. This is quite inefficient at the moment and if left running for prolonged periods will eat up your disk space. Otherwise works okay. Not all conky variables work well, will take a bit of trial and error.

`conky = Barr::Blocks::Conky.new string: "${cpu}"`

| Option | Value | Description | Default |
| --- | --- | --- | --- | 
| `text` | Conky 'TEXT' string | String made up of [one or more conky variables](http://conky.sourceforge.net/variables.html), as you might find in the `TEXT` section of a conkyrc | **REQUIRED** | 

#### CPU

Shows CPU load averaged across all cores.

`cpu = Barr::Blocks::CPU.new`

There are no `CPU` block specific configurable options.

#### HDD

Shows selected filesystem's used and free space.

`hdd = Barr::Blocks::HDD.new device: 'sda2'`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `device` | String | This is the name of the device for which you'd like to see free/used space. Something like `/dev/sda2`. Run `df -h` in your terminal and look at the first column.  | **REQUIRED** |

#### I3

**Requires i3wm**. Shows the current workspaces and highlights the active one. You can click a workspace name to change to there.

`i3 = Barr::Blocks::I3.new focus_markers: ["\u02C3",'']`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `focus_markers` | 2 element Array | These are used to 'highlight' the active workspace. The first element is used on the left of the active workspace, the second element on the right. | ['>', '<'] |
| `invert_focus_colors` | bool | Should the block's `fgcolor` and `bgcolor` attributes be reversed for the workspace that is currently focused. | `false` |

#### ip

Shows the selected adaptor's IP (IPv4 by default) address. If no device is specified, it will make a guess.

`ip = Barr::Blocks::IP.new device: 'enp3s0'`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `device` | String | The name of the device | `192` |
| `ipv6` | Boolean | Get the IPv6 address of the device | `false` |

#### Mem

Shows current RAM usage.

`mem = Barr::Blocks::Mem.new`

There are no `Mem` block specific configurable options.

#### Processes

Shows the number of currently active processes on your system.

`proc = Barr::Blocks::Processes.new`

There are no `Processes` block specific configurable options.

#### Rhythmbox

**Requires Rhythmbox and rhythmbox-client**. Shows currently playing artist and/or track, as well as control buttons. Control buttons use FontAwesome.

`rb = Barr::Blocks::Rhythmbox.new buttons: false`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `artist` | bool | Set to `true` or `false` to set whether or not the currently playing artist should be shown. | `true` |
| `buttons` | bool | As above, but for the player control buttons | `true` |
| `title` | bool | As above, but for the track title | `true` |


#### Separator

This block is a simple string to be used as a separator between other blocks.

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `symbol` | any string | The string to use as a separator | `&#124;`


#### Temperature

Shows the current temperature and summary of a given location ID. Clicking it will open the full report in your browser.

`temp = Barr::Blocks::Temperature.new location: '11921', unit: 'F'`

| Option | Value | Description | Default |
| --- | --- | --- | --- |
| `location` | Yahoo Weather string | The ID [Yahoo Weather](https://weather.yahoo.com) uses for your chosen location. Search for your location then use the number that appears at the end of the URL. For example, New York is 2459115| **REQUIRED** |
| `unit` | `'C'` or `'F'` | Choose between Celcius and Fahrenheit. | `'C'` |


#### Whoami

Shows the currently logged in user.

`who = Barr::Blocks::Whoami.new`

There are no `Whoami` block specific configurable options.



## Create Your Own Block

It's reasonably simple to add your own block to your script. Create a `class` that inherits from `Barr::Block` and add your custom `initialize` and `update!` methods. The `Barr::Manager` object will read your block's `@output` on each update.

For example, a block which increments an integer might look like this:

```ruby
#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

class Incrementer < Barr::Block

    def initialize opts={}  # Don't forget to accept your options hash!

      # super ensures the common configurable options can be set
      super

      # Accept a 'count' option, defaulting to 0 if none is provided
      @count = opts[:count] || 0
    end

    def update!

      # Increment the current count
      @count += 1

      # Set the @output to be the current count. This is what will be sent to lemonbar
      @output = @count.to_s
    end

end

@man = Barr::Manager.new

block = Incrementer.new count: 1, align: :r
@man.add block

@man.run!
```

## TODO

Here are a few things I have planned

* MPD support
* Powerline styling options
* More configuration for existing blocks
* Some form of Conky support
* Volume display / control
* Stricter option typing
* RSS support

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OkayDave/barr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

I'd love to see PRs for more blocks. If you do make any, please ensure that you've added their config options to this README and that you've written some specs for it (including stubbing / mocking out any system and/or API calls it makes).

If there's a block you'd like to see, but don't have the time, knowledge, or desire to make one then please do open a request on the [Issue Tracker](https://github.com/OkayDave/barr/issues).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
