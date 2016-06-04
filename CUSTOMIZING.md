## Customizing

It's easy to customize behavior!

```ruby
class User < Hello::RailsActiveRecord::User
  def user?
    %w(user webmaster).include?(role)
  end
end

module Hello
  module Concerns
    module Registration
      module SignUp

        def on_success
          deliver_welcome_email
          deliver_confirmation_email
          redirect_to root_path
        end

      end
    end
  end
end
```





## Customizing - behavior and views

These files are generated when you install this gem.

They are simple to customize, just open them.

    ├── app/
    │   ├── controllers/
    │   │   ├── hello/
    │   │   │   └── concerns/
    │   │   │       └── [...optional...]
    │   │   ├── onboarding_controller.rb
    │   │   └── users_controller.rb
    │   │
    │   ├── models/
    │   │   └── user.rb
    │   │
    │   ├── views/
    │   │   ├── hello/
    │   │   │   └── [...optional...]
    │   │   ├── layouts/
    │   │   │   └── application.html.erb
    │   │   ├── onboarding/
    │   │   │   └── index.html.erb
    │   │   └── users/
    │   │       ├── index.html.erb
    │   │       ├── show.html.erb
    │   │       └── new.html.erb
    │   │
    ├── config/
    │   └── initializers
    │       └── hello.rb
    │
    └── db/
        └── migrate/
            ├── 1_create_credentials.hello.rb
            ├── 2_create_accesses.hello.rb
            └── 3_create_users.hello.rb







