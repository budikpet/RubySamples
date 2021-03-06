# Batch rename CLI utility

A Thor powered CLI tool for batch rename of multiple files. Inspired by built-in batch rename tool of MacOS Finder.

**Functionalities**:
  - edit names using basic text search & replace
  - edit names using REGEX search & replace
  - append and/or prepend text to all file names
  - rewrite all filenames using provided template
    - i. e. rename all files to SomeFile1, SomeFile2...
    
## How to install

The project is packaged as a standard gem but it isn't released on RubyGems.org.

If you **download** the whole repository from GitHub (either manually or using git clone) you need to install the gem like this:

```bash
# Install all necessary dependencies from Gemfile
$ bundle install

# Build and install the gem using currency_convertor.gemspec
$ gem build currency_convertor.gemspec          # creates a file currency_convertor-<version>.gem which is used to install the gem
$ gem install ./currency_convertor-0.1.0.gem
```

## Usage

Get help:
```bash
$ currency_convertor -h

or

$ ./currency_convertor.rb -h
```

Run tests:
```
$ rspec spec
```

Generate documentation:
```
$ yardoc 'lib/**/*.rb'
```
