Localization
------------

  - [![Gem Version](https://badge.fury.io/rb/localization.png)](https://rubygems.org/gems/localization)
  - [![Code Climate](https://codeclimate.com/github/krainboltgreene/localization.png)](https://codeclimate.com/github/krainboltgreene/localization)
  - [![Build Status](https://travis-ci.org/krainboltgreene/localization.png)](https://travis-ci.org/krainboltgreene/localization)
  - [![Dependency Status](https://gemnasium.com/krainboltgreene/localization.png)](https://gemnasium.com/krainboltgreene/localization)
  - [![Coverage Status](https://coveralls.io/repos/krainboltgreene/localization/badge.png?branch=master)](https://coveralls.io/r/krainboltgreene/localization)


The `localization` gem's goal is to provide a smarter more object-oriented approach to internationalization.


Using
=====

**RAILS**

In Rails, you'll want to start with making sure your Gemfile requires the right piece:

``` ruby
# Gemfile

# ...
gem "localization", "~> 1.1", require: "localization/railtie"
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

    gem "localization", "~> 1.1"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localization


Contributing
============

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request


Licensing
=========

Copyright (c) 2013 Kurtis Rainbolt-Greene

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
