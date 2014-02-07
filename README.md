localization
------------

  - [![Quality](http://img.shields.io/codeclimate/github/krainboltgreene/localization.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/localization.gem)
  - [![Coverage](http://img.shields.io/codeclimate/coverage/github/krainboltgreene/localization.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/localization.gem)
  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/localization.gem.svg?style=flat-square)](https://travis-ci.org/krainboltgreene/localization.gem)
  - [![Dependencies](http://img.shields.io/gemnasium/krainboltgreene/localization.gem.svg?style=flat-square)](https://gemnasium.com/krainboltgreene/localization.gem)
  - [![Downloads](http://img.shields.io/gem/dtv/localization.svg?style=flat-square)](https://rubygems.org/gems/localization)
  - [![Tags](http://img.shields.io/github/tag/krainboltgreene/localization.gem.svg?style=flat-square)](http://github.com/krainboltgreene/localization.gem/tags)
  - [![Releases](http://img.shields.io/github/release/krainboltgreene/localization.gem.svg?style=flat-square)](http://github.com/krainboltgreene/localization.gem/releases)
  - [![Issues](http://img.shields.io/github/issues/krainboltgreene/localization.gem.svg?style=flat-square)](http://github.com/krainboltgreene/localization.gem/issues)
  - [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://opensource.org/licenses/MIT)
  - [![Version](http://img.shields.io/gem/v/localization.svg?style=flat-square)](https://rubygems.org/gems/localization)


The `localization` gem's goal is to provide a smarter more object-oriented approach to internationalization.


Using
=====

**RAILS**

In Rails, you'll want to start with making sure your Gemfile requires the right piece:

``` ruby
# Gemfile

# ...
gem "localization", "~> 4.0", require: "localization/railtie"
# ...
```

Second you'll want to actually have some locale files like this:

``` yml
# lib/locales/en.yml
---
accounts:
  index:
    account_list_header: "All Accounts ({{size}} total)"
```

We render the strings with mustache, so you get the benefit of that library.

Now you'll probably want to access that value in a view somewhere:

``` erb
<!--- app/views/accounts/index.html.erb --->
<h1><%= view_localize.account_list_header(size: @accounts.size) %></h1>

<!--- ... --->
```

Of course if you're like me you probably want this in a presenter and want to build the path yourself:

``` ruby
class AccountsDecorator
  # ...
  def size
    localize.accounts.index.account_list_header(size: source.size)
  end
  # ...
end
```

For rails you have access to these shortcuts:

  - `view_localize` or `action_localize` which is equal to `localize.{{controller_name}}.{{action_name}}`
  - `control_localize` which is the same as `localize.{{controller_name}}`
  - Finally `localize` which is equal to `Localize.new.{{locale_name}}` like `Localize.new.en`


**OTHER**

If you're not wanting that rails interface but want a `localize` shortcut method then you'll need to do:

``` ruby
require "localization/main"
```

Of course you'll now need to specify a load path for localizations:

``` ruby
require "localization/main"

locale_files = Dir[File.join(".", "locale", "*.yml")]
  # => ["./locale/en.yml"]

Localization.sources = locale_files
```

At which point you can start using thusly:

``` ruby
require "localization/main"

locale_files = Dir[File.join(".", "locale", "*.yml")]
  # => ["./locale/en.yml"]

Localization.sources = locale_files

Localization.new.en.accounts.index.account_list_header(size: 3)
```


Installing
==========

Add this line to your application's Gemfile:

    gem "localization", "~> 4.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install localization


Contributing
============

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request


Changelog
=========

  - 1.0.0: Initial release


Conduct
=======

As contributors and maintainers of this project, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for everyone, regardless of level of experience, gender, gender identity and expression, sexual orientation, disability, personal appearance, body size, race, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or imagery, derogatory comments or personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed from the project team.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the [Contributor Covenant](http:contributor-covenant.org), version 1.0.0, available at [http://contributor-covenant.org/version/1/0/0/](http://contributor-covenant.org/version/1/0/0/)


License
=======

Copyright (c) 2014, 2015 Kurtis Rainbolt-Greene

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
