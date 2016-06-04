## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request





## Contributing With Translations

Link to [Translation files](https://github.com/hello-gem/hello/blob/master/config/locales/hello.en.yml)

Link to [Our Locale Contributors](https://github.com/hello-gem/hello/blob/master/LOCALES.md)

1. change the initializer `config.locales = %w(en es pt-BR <NL>)`
  1. dummy initializer `spec/dummy/config/initializers/hello.rb`
  2. initializer template `lib/generators/hello/install/templates/initializer.rb`
2. update locale test in `spec/controllers/localization_spec.rb`
3. create and modify the locale file `config/locales/hello.<NEW_LANGUAGE>.yml`
4. ensure consistency with this test `bundle exec rspec spec/others/localization_consistency_spec.rb spec/controllers/localization_spec.rb`
5. Thank You! Submit your Pull Request `:)`

