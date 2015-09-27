# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module SignOut

      def success
        respond_to do |format|
          # format.html { redirect_to hello.root_path }
          # format.html { redirect_to root_path }
          format.html { redirect_to '/' }
          format.json { head :reset_content }
        end
      end

    end
  end
end
