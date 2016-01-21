class Hello::ConcernsGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path('../../../../../', __FILE__)

  def copy_the_controller_concerns
    directory 'app/controllers/hello/concerns'
  end

  protected
end
