# HELLO

/ [HELLO]() / [FAQ]() / [HOW TO]() / [AUTHENTICATION]() / AUTHORIZATION

# AUTHORIZATION


## TO CUSTOMIZE AUTHORIZATION SYSTEM


> 1. You can override the four basic question-mark role-methods

```ruby
class User < ActiveRecord::Base
  include Hello::User

  def guest?
    %w(guest).include?(role)
  end

  def onboarding?
    %w(onboarding).include?(role)
  end

  def user?
    %w(user webmaster).include?(role)
  end

  def webmaster?
    %w(webmaster).include?(role)
  end
end
```

> 2. You can create custom roles

```ruby
  def student?
    %w(student).include?(role)
  end

  def teacher?
    %w(teacher).include?(role)
  end

  def user?
    %w(user webmaster principal student teacher).include?(role)
  end
```

[top](#)
