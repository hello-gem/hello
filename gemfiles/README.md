
# Running Tests

Note You do NOT need to run migrations to run tests

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
BUNDLE_GEMFILE=gemfiles/rails-5-0-stable.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rails-5-0-stable.gemfile bundle exec rspec
```


## Running the Dummy App on Development Mode

Note: the dummy app uses SQLite3

```bash
cd spec/dummy
rake db:migrate
rails server
```
