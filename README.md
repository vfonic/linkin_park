# LinkinPark

Perf comparison:

```
bundle exec exe/linkin_park crawl "https://gocardless.com"  28.67s user 2.36s system 15% cpu 3:18.27 total

parallel:
bundle exec exe/linkin_park crawl "https://gocardless.com"  28.88s user 2.50s system 16% cpu 3:15.62 total

wget
FINISHED --2015-07-28 19:20:46--
Total wall clock time: 2m 40s
Downloaded: 979 files, 46M in 27s (1.69 MB/s)
```

Implementation Thoughts
-----------------------

Selective crawling vs full crawling
Multithreading/multi processing - multi processing on machine level - inifinite scaling
Downloading set of typical additional website resources
Handling file_name == dir_name issue
Overloading websites



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linkin_park'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linkin_park

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/linkin_park. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

