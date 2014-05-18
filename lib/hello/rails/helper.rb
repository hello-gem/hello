module Hello
  module Rails
    module Helper
      

    end
  end
end

if defined? ActionView::Base
  ActionView::Base.class_eval do
    include Hello::Rails::Helper
  end
end
