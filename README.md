# Hello

[![Build Status](https://travis-ci.org/hi/hello.svg)](https://travis-ci.org/hi/hello)
[![Code Climate](https://codeclimate.com/github/hi/hello.png)](https://codeclimate.com/github/hi/hello)
[![Dependency Status](https://gemnasium.com/hi/hello.svg)](https://gemnasium.com/hi/hello)

This project rocks and uses MIT-LICENSE.



#### When writing tests, remember...

Controllers

      module Hello
        describe UsersController do
          describe "routing" do
            routes { Hello::Engine.routes }

Routing

      module Hello
        describe UsersController do
          routes { Hello::Engine.routes }



