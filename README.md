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

Implementation Details
-----------------------

* I made the crawler as a ruby gem
* It can work as a standalone CLI tool (with `linkin_park` executable) or from within the ruby project
* There are several reusable components that can be used in other applications: `file_storage`, `scraper`, `uri_converter`, `uri_fetcher`. None of these are nested under LinkinPark module for a reason.
* There's no parallelization at the moment. [Here's](https://github.com/vfonic/linkin_park/commit/cccd526c0df1503628b05f0bb91a9a014a6f51ff) the try on parallelization that yielded the same results as without parallelization, due to MRI's green threads/global interpreter lock.

Other Thoughts
--------------

* Selective crawling vs full crawling
* Multithreading/multi processing - this could be achieved with sidekiq or sucker_punch or the likes
* Parallelization on machine level - "inifinite" scaling
* Downloading set of typical additional website resources
* Handling `file_name == dir_name` issue
* Overloading websites
* Tests are missing

## Installation

1. Clone git repo
2. Run `bundle`
2. Run `rake install`

linkin_park comes with a CLI.

To display help, simply run:

    `linkin_park`

To run the crawler, run:

    `linkin_park crawl http://example.com`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vfonic/linkin_park. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

