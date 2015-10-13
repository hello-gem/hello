
# Running Tests

## With base gemfile

```bash
bundle install
bundle exec rspec
```

## With different gemfiles


```bash
BUNDLE_GEMFILE=gemfiles/rails-master.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rails-master.gemfile bundle exec rspec
```

```bash
BUNDLE_GEMFILE=gemfiles/rails-4-1-stable.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rails-4-1-stable.gemfile bundle exec rspec
```

```bash
BUNDLE_GEMFILE=gemfiles/rails-4-2-stable.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rails-4-2-stable.gemfile bundle exec rspec
```
