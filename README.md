# READ ME

[![Build Status](https://travis-ci.org/hi/hello.svg)](https://travis-ci.org/hi/hello)

This is a brand new code base catered for real world needs for our Rails apps and we want to share it with the world.




## With Great test coverage comes great readability

[![Code Climate](https://codeclimate.com/github/hi/hello.png)](https://codeclimate.com/github/hi/hello)
[![Code Climate](https://codeclimate.com/github/hi/hello/coverage.png)](https://codeclimate.com/github/hi/hello)



## Rails support

Ruby __1.9.3__ through __2.1.0__

Rails __4.0__ and above




## What makes it so awesome and unique?


  Hello assumes every web application has special needs regarding authentication,
  So we give you a high quality vanilla and let you cater in from the start.

## Installation

Add to your Gemfile:

```ruby
gem 'hello', github: 'hi/hello', branch: 'v0.1.0'
gem 'bcrypt'
```

Then run:

```bash
rails g hello
rails g hello:views # optional
```

Yes, Hello only requires a few columns at your users table

```ruby
create_table "users" do |t|
  t.string   "name"
  t.string   "role", default: "user"
  t.string   "language"
  t.string   "time_zone"
end
```

All your authentication routes go inside _/hello_

```ruby
Rails.application.routes.draw do
  mount Hello::Engine => "/hello"
end

```

Customize what you need

    + app/
    | + lib/
    | | + hello/
    | |   - sign_up.rb
    | |   - sign_in.rb
    | |   - sign_out.rb
    | |   - forgot.rb
    | |   - reset.rb
    | + view/
    |   + hello/
    |       ...




## Usage

You only need to include our module in your User class

```ruby
class User < ActiveRecord::Base
  include Hello::UserModel

  # uncomment the line below if you want username
  # validates_presence_of :username

end
```

We let you customize everything

```ruby
require 'bcrypt'

class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  def encrypt_password(plain_text_password)
    BCrypt::Password.create(plain_text_password)
  end

end
```





## Demo App

Want to see it live?

Then play with it at [https://bit.ly/hellogem](https://bit.ly/hellogem)
Sources at [https://github.com/hi/hello_demo](https://github.com/hi/hello_demo)





This project rocks and uses MIT-LICENSE.

