# HELLO

# HOW TO

# CREATE CUSTOM ROLES

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


```ruby
```

```ruby
```


[< Back to HOW TO](https://github.com/hello-gem/hello)

[< Back to README](https://github.com/hello-gem/hello)
