# Hello

A Rails Engine.<br>
Provides a set of valuable features for Registration, Authentication, Management and Internationalization.





## Tested With The Latest

| <image width=16 src='https://www.ruby-lang.org/images/header-ruby-logo.png'> Ruby 2.3 | <image width=16 src='https://www.ruby-lang.org/images/header-ruby-logo.png'> Ruby 2.4.0-dev  | <image width=16 src='https://upload.wikimedia.org/wikipedia/en/thumb/e/e9/Ruby_on_Rails.svg/16px-Ruby_on_Rails.svg.png'> Rails 5.0 |
| :--- | :--- | :--- |





## Status

| Is It Working? | Is It Tested? | Code Quality |
|:---|:---|:---|
| [![Master Build Status](https://api.travis-ci.org/hello-gem/hello.svg?branch=master)](https://travis-ci.org/hello-gem/hello) | [![Code Climate](https://codeclimate.com/github/hello-gem/hello/coverage.svg)](https://codeclimate.com/github/hello-gem/hello) | [![Code Climate](https://codeclimate.com/github/hello-gem/hello.svg)](https://codeclimate.com/github/hello-gem/hello) |
| **# of Downloads** | **Maintainance Status** | **Get Involved!** |
| [![Downloads](http://img.shields.io/gem/dt/hello.svg)](https://rubygems.org/gems/hello) | [![Dependency Status](https://gemnasium.com/badges/github.com/hello-gem/hello.svg)](https://gemnasium.com/github.com/hello-gem/hello) | [![GitHub Issues](https://img.shields.io/github/issues/hello-gem/hello.svg)](https://github.com/hello-gem/hello/issues) |






## Install

```ruby
Gemfile

gem 'hello-rails'
gem 'bcrypt'   # bcrypt is a requirement
gem 'nav_lynx' # nav_lynx is optional, add it if you are using hello for the first time
```

```shell
Terminal

bundle install
bundle exec rails generate hello:install
bundle exec rails generate hello:users # our customized scaffold controller
bundle exec rake db:migrate
```





## How To

* Please read [Customizing](https://github.com/hello-gem/hello/blob/master/CUSTOMIZING.md)
* Chat: [Gitter chat](https://gitter.im/hello-gem/hello)







## Contributing

* Please read [Running Tests](https://github.com/hello-gem/hello/blob/master/gemfiles) and  [Contributing](https://github.com/hello-gem/hello/blob/master/CONTRIBUTING.md)





## Versions

[Semantic Versioning 2.0.0](http://semver.org)







# Thank You

[Tim Lucas](https://github.com/toolmantim), [John Nunemaker](https://github.com/jnunemaker), [Dan Everton](https://github.com/deverton) and [Johan Andersson](https://github.com/rejeep) or their open source gem [user_agent_parser](https://github.com/toolmantim/user_agent_parser). As well as [Tobie Langel](https://github.com/tobie) and everybody involved in [BrowserScope](http://www.browserscope.org/) ([full list](https://code.google.com/p/browserscope/people/list)), as our device and browser detection derives from their open-source work.

[Iain Hecker](https://github.com/iain) for his open source gem [http_accept_language](https://github.com/iain/http_accept_language) that helps us understand browser's favorite locales.

[Brian Landau](https://github.com/brianjlandau) and [Ryan Foster](https://github.com/fosome) for [NavLynx](https://github.com/vigetlabs/nav_lynx) as well as everybody on the [Bootstrap Team](https://github.com/orgs/twbs/people) as we use these open source projects on our generated view code.





## Copyright

Copyright 2013-2016 James Pinto – Released under [MIT License](http://www.opensource.org/licenses/MIT)
