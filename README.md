## Status

<!-- [![Build Status](https://travis-ci.org/hello-gem/hello.svg)](https://travis-ci.org/hello-gem/hello) [![Code Climate](https://codeclimate.com/github/hello-gem/hello.svg)](https://codeclimate.com/github/hello-gem/hello) [![Code Climate](https://codeclimate.com/github/hello-gem/hello/coverage.svg)](https://codeclimate.com/github/hello-gem/hello) [![Dependency Status](https://gemnasium.com/hello-gem/hello.svg)](https://gemnasium.com/hello-gem/hello) [![Inline docs](http://inch-ci.org/github/hello-gem/hello.svg?branch=master)](http://inch-ci.org/github/hello-gem/hello) -->

| Hello |  |
| ------------- |---------------------|
| TravisCI | [![Build Status](https://travis-ci.org/hello-gem/hello.svg)](https://travis-ci.org/hello-gem/hello) |
| Version |  [![Gem Version](https://img.shields.io/gem/v/hello.svg)](https://rubygems.org/gems/hello) |
| Downloads | [![Gem Downloads](http://img.shields.io/gem/dt/hello.svg)](https://rubygems.org/gems/hello) |
| CodeClimate | [![Code Climate](https://codeclimate.com/github/hello-gem/hello.svg)](https://codeclimate.com/github/hello-gem/hello) [![Code Climate](https://codeclimate.com/github/hello-gem/hello/coverage.svg)](https://codeclimate.com/github/hello-gem/hello) |
| Gemnasium | [![Dependency Status](https://gemnasium.com/hello-gem/hello.svg)](https://gemnasium.com/hello-gem/hello) |
| InchCI | [![Inline docs](http://inch-ci.org/github/hello-gem/hello.svg?branch=master)](http://inch-ci.org/github/hello-gem/hello) |

## Introduction

Two things I love are [Ruby](http://www.ruby-lang.org/en/) and [Rails](http://rubyonrails.org/).
Rale as espigas ou corte-as rente ao sabugo e passe no liquidificador, juntamente com a `água` Acrescente o `coco`, o `açúcar` e mexa bem Coloque a massa na palha de milho e amarre bem. Em uma panela grande ferva bem a água, e vá colocando as pamonhas uma a uma após a fervura completa da água

----

### Goals & Features

> Our goal is to implement various User-centered features in your Rails App.
>
> Must-haves and Nice-to-haves, always good defautls, always easy to extend.
>
> Specifically:

#### International Support
1. - [x] User Language _(Browser + API)_ [_specification_](./spec/bdd/hello/internalionalization/anyone_can_change_their_locale)
1. - [x] User Timezone _(Browser + API)_ [_specification_](./spec/bdd/hello/internalionalization/anyone_can_change_their_timezone)

#### User Registration
1. - [x] Email Registration _(Browser + IFrame + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Onboarding Process _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] User Profiles _(Browser only)_ [_specification_](./spec/bdd/hello)

#### Account Management
1. - [x] Cancel Account _(Browser only)_ [_specification_](./spec/bdd/hello)
1. - [x] Manage Profile _(Browser & API)_ [_specification_](./spec/bdd/hello)
1. - [x] Manage Email Credentials _(Browser & API)_ [_specification_](./spec/bdd/hello)
1. - [x] Manage Password Credentials _(Browser & API)_ [_specification_](./spec/bdd/hello)
1. - [ ] OAuth Registration [_help wanted_][issues_url]

#### User Authentication
1. - [x] Email Authentication _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Sign Out _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Unlink Devices _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Role-based Authorization _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Route Authorization _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Sudo-mode Authorization _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] Switch Account _(Browser + API)_ [_specification_](./spec/bdd/hello)
1. - [x] HTTP Headers Authentication _(API only)_ [_specification_](./spec/bdd/hello)
1. - [x] Parameter Authentication _(API only)_ [_specification_](./spec/bdd/hello)
1. - [ ] OAuth Authentication [_help wanted_][issues_url]


<!-- 
#### System Management (Browser only)
1. - [x] Impersonate User 
1. - [ ] ~~Block User~~ [_help wanted_][issues_url]
 -->


----

## Tested With

| Ruby Versions | Rails Versions      |
| ------------- |---------------------|
| Ruby 2.0.*    | Rails 4.1.*         |
| Ruby 2.1.*    | Rails 4.2.*         |
| Ruby 2.2.*    | Rails 5 beta (soon) |


| JRuby (soon)  |  |
| Rubinius (soon) |  |


## Running Tests

Please read [Running Tests](https://github.com/hello-gem/hello/blob/master/gemfiles)


## Install

Add this line to your application's Gemfile:

```ruby
gem 'hello', github: 'hello-gem/hello' # latest from github while this gem is in rapid development
```

And then execute:

```bash
bundle install
bundle exec rails generate hello:install
bundle exec rake db:migrate
bundle exec rails generate hello:extensions # optional
bundle exec rails generate hello:views   # optional
```

## Customizing - behavior and views

These files are generated when you install this gem.

They are simple to customize, just open them.

    ├── app/
    │   ├── controllers/
    │   │   ├── onboarding_controller.rb
    │   │   └── users_controller.rb
    │   ├── models/
    │   │   ├── credential.rb
    │   │   ├── active_session.rb
    │   │   └── user.rb
    │   ├── views/
    │   │   ├── hello/
    │   │   │   └── [...optional...]
    │   │   ├── layouts/
    │   │   │   └── application.html.erb
    │   │   ├── onboarding/
    │   │   │   └── index.html.erb
    │   │   └── users/
    │   │       ├── index.html.erb
    │   │       └── show.html.erb
    │   └── lib/
    │       └── hello/
    │           └── extensions/
    │               └── [...optional...]
    ├── config/
    │   └── initializers
    │       └── hello.rb
    └── db/
        └── migrate/
            ├── 1_create_credentials.hello.rb
            ├── 2_create_accesses.hello.rb
            └── 3_create_users.hello.rb








## Customizing

```ruby
class User < ActiveRecord::Base
  validates_presence_of :username
end

module Hello
  module Extensions
    module EmailSignUp

      def success
        deliver_welcome_email
        deliver_confirmation_email
        redirect_to root_path
      end

      def failure
        render action: 'index'
      end

    end
  end
end
```


## Demo

Want to see it in action?

* Visit https://bit.ly/hellogem
* Sources at https://github.com/hello-gem/hello_demo



## References

* Home page: https://github.com/hello-gem/hello
* API Doc: https://github.com/hello-gem/hello
* Version: https://github.com/hello-gem/hello
* Trello Board: https://trello.com/b/WwNptyVM/hello-gem

## Support

* Bugs/Issues: https://github.com/hello-gem/hello/issues
* Support: http://stackoverflow.com/questions/tagged/hello
* Support/Chat: [![Gitter chat](https://badges.gitter.im/hello-gem/hello.png)](https://gitter.im/hello-gem/hello)







# Thank You

[Tim Lucas](https://github.com/toolmantim), [John Nunemaker](https://github.com/jnunemaker), [Dan Everton](https://github.com/deverton) and [Johan Andersson](https://github.com/rejeep) or their open source gem [user_agent_parser](https://github.com/toolmantim/user_agent_parser). As well as [Tobie Langel](https://github.com/tobie) and everybody involved in [BrowserScope](http://www.browserscope.org/) ([full list](https://code.google.com/p/browserscope/people/list)), as our device and browser detection derives from their open-source work.

[Iain Hecker](https://github.com/iain) for his open source gem [http_accept_language](https://github.com/iain/http_accept_language) that helps us understand browser's favorite locales.

[Brian Landau](https://github.com/brianjlandau) and [Ryan Foster](https://github.com/fosome) for [NavLynx](https://github.com/vigetlabs/nav_lynx) as well as everybody on the [Bootstrap Team](https://github.com/orgs/twbs/people) as we use these open source projects on our generated view code.




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Versioning

__Hello__ uses [Semantic Versioning 2.0.0](http://semver.org)

## Copyright

Copyright 2013-2014 James Pinto – Released under [MIT License](http://www.opensource.org/licenses/MIT)


## Additional

Look for these terms in the source code

"TODO", "KNOWNBUG"

## Known bugs

  1. (Rails 4.0 only) Top Feature Set: Current User Feature Set: Settings Feature: Cancel Account Invalid Scenarios Validation: has_many restrict_with_error Scenario 2: User has dependent grandchildren

## To Do

  1. One translation missing: config/locales/*.yml

  2. Test this method: Hello::Rails::Controller::AccessRestrictionConcern::ClassMethods#restrict_if_role_is

  3. Generate Access Token Feature

[issues_url]: https://github.com/hello-gem/hello/issues
