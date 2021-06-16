# Opnsrcint

[](https://img.shields.io/gem/v/opnsrcint)
[](https://img.shields.io/gem/dt/opnsrcint)
[](https://img.shields.io/gem/rt/opnsrcint)
[](https://img.shields.io/gem/dtv/opnsrcint)
[](https://img.shields.io/github/license/Madhava-mng/opnsrcint)


OSINT tool for searching username,subdomain finding using dns
such as google, cloudflare, opendns, ..

* written in ruby

## requirement:

* ruby env

## Installation

```ruby
gem 'opnsrcint'
bundle install
```

**Or install it yourself as:**

```ruby
gem install opnsrcint
```

## Usage
```ruby
opnsrcint [cmd] [argv]
```

**search user names:** 

```ruby
opnsrcint scan4user user1,user2
```

**searching subdomains:**

```ruby
opnsrcint subenum example.com
```

## example for irb

```ruby
irb(main):001:0> require 'opnsrcint'
irb(main):002:0> Opnsrcint::search_for_username(
	["test"],	# list of user names
	false,	# verbose
	false	# enable 18+ site
 )
irb(main):003:0> sub = Subdomain_enum::new
irb(main):004:0> sub.target = 'example.com'	# require
irb(main):005:0> sub.wordlist = '/path/to/wordlist'	# defaultly wordlist set
irb(main):006:0> sub.max_thread = 10	# defaultly set
irb(main):007:0> sub.timeout = 1	# defaultly value set
irb(main):008:0> sub.brut	# start searching
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Madhava-mng/opnsrcint.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
