# TMSync

Translation Management Synchronization tool for any translation management service & platform.

## Installation

Simply run the following to install it:

    $ gem install tmsync

## Usage

Run TMSync simply by calling `tmsync execute` in the command line. The following options are **required**:

- `--path=` / `-p`: Specify the absolute path to search for localization files. Usually the root directory of your project.
- `--command=` / `-cmd`: Specify the command of your translation manager to download/upload a single translation file. `<LANGUAGE>` and `<FILE_PATH>` will be replaced by the according values.

In addition to the required fields you need to either specify a platform (currently supported: `ios`, `android`) **OR** you need to specify a matching regular expression as well as an exclusion regular expression yourself. Note that the matching regular expression needs to have a capture group which catches the language so you can access `<LANGUAGE>` in your command:
- `--platform=`: Preconfigured regexes for the iOS and Android platform. Specify `ios` or `android`.
- `--matching_regex=` / `-matching`: Specify a custom regex for matching the translation files in search. This should include a catch group for the language.
- `--exclude_regex=` / `-exclude`: Specify a custom for excluding some files that were found with the matching regex.

Here's a **complete example for iOS**:

```
tmsync execute --command="echo <LANGUAGE> <FILE_PATH>" -p "/absolute/path/to/project" --platform=ios
```

Here's a **complete example for Android**:

```
tmsync execute --command="echo <LANGUAGE> <FILE_PATH>" -p "/absolute/path/to/project" --platform=android
```

Here's a **complete custom example**:

```
tmsync execute --command="echo <LANGUAGE> <FILE_PATH>" -p "/Users/JamitLabs/Code/Apple/FitterYou" -matching ".*\/\S+\.(\S+)\.yml"
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JamitLabs/TMSync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tmsync project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/JamitLabs/TMSync/blob/stable/CODE_OF_CONDUCT.md).
