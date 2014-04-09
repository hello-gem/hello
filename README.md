# Hello

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



