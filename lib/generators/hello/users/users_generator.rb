class Hello::UsersGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_the_files
    directory 'app'
  end

  def append_the_routes
    route %(
  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get 'list'
    end
    member do
      post 'impersonate'
    end
  end
)
  end

end
