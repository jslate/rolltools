# Rolltools

Just a simple gem that gives you ruby methods and command line tools to display info from the Rollbar API. 

## Installation

    $ gem install rolltools

Or in your Gemfile:

    gem 'rolltools'

## Usage - Command Line

Run 'rolltools' to get a list of commands.

Typical usage from command line:

    rolltools set_config read_token abc123... # will set token in ~/.rolltools.yml
    
    rolltools user_agents 2269 -l 2 # user agents for #2269 TypeError: no implicit conversion of nil into String, limit 2

    > Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko
    > Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko

    rolltools exceptions 2269 -l 2 # Exception messages for #2269, limit 2

    > TypeError no implicit conversion of nil into String
    > TypeError no implicit conversion of nil into String

_The default limit is 20, which is one page of items. If you specify a limit > 20 it will result in more requests to Rollbar._

## Usage - Ruby

    require 'rolltools'

    Rolltools::Settings.settings = { 'read_token' => 'abc123'}
    puts Rolltools::Utils.get_items('3002').first(10).map{|i|i[:user_agent]}.inspect

_Similarly, if you get > 20 items it will result in more requests to Rollbar._

## Contributing

1. Fork it ( http://github.com/jslate/rolltools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
