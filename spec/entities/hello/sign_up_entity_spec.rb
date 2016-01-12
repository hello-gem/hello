require 'spec_helper'

module Hello
  describe SignUpEntity do

    describe ".register(email:string, username:string, password:string)" do

      let(:valid_attrs) { {city: "Brasilia", name: "James Pinto", email: "foo@bar.com", username: "foobar", password: "foobar"} }

      describe "original state" do
        it("no errors")           { expect(subject.errors.messages).to eq({}) }
      end # describe

      describe "all blank" do
        before do
          subject.register({})
        end
        it("a lot of errors")       { expect(subject.errors.messages).to eq({:email=>["can't be blank"], :name=>["can't be blank"], :city=>["can't be blank"], :password=>["can't be blank"], :username=>["can't be blank"]}) }
      end # describe

      describe "by field" do

        def perform
          if value
            valid_attrs[field] = value
          else
            valid_attrs.delete(field)
          end
          subject.register(valid_attrs)
          @errors = subject.errors[field]
        end

        after do
          reload_initializer!
        end



        describe "email" do

          before do
            perform
          end

          let(:field) { :email }

          describe "ignored" do
            let(:value) { nil }
            it("has errors") { expect(@errors).to eq(["can't be blank"]) }
          end # describe

          describe "blank" do
            let(:value) { '' }
            it("has errors") { expect(@errors).to eq(["can't be blank"]) }
          end # describe

          describe "invalid" do
            let(:value) { "foo" }
            it("has errors") { expect(@errors).to eq(["does not appear to be a valid e-mail address"]) }
          end # describe

          describe "valid" do
            let(:value) { "foo@bar.com" }
            it("does not have errors") { expect(@errors).to eq([]) }
          end # describe

        end # describe

        describe "username" do

          before do
            perform
          end

          let(:field) { :username }

          describe "ignored" do
            let(:value) { nil }
            it("has errors") { expect(@errors).to eq(["can't be blank"]) }
          end # describe

          describe "blank" do
            let(:value) { '' }
            it("has errors") { expect(@errors).to eq(["can't be blank"]) }
          end # describe

          describe "invalid" do
            let(:value) { "foobar!" }
            it("has errors") { expect(@errors).to eq(["is invalid"]) }
          end # describe

          describe "valid" do
            let(:value) { "foobar" }
            it("does not have errors") { expect(@errors).to eq([]) }
          end # describe

        end # describe

        describe "password" do

          let(:field) { :password }

          describe "config.password_presence = true" do

            before do
              Hello.configure { |config| config.password_presence = true }
              perform
            end

            describe "ignored" do
              let(:value) { nil }
              it("has errors") { expect(@errors).to eq(["can't be blank"]) }
              it("does not register") { expect(::User.count).to eq(0) }
            end # describe

            describe "blank" do
              let(:value) { '' }
              it("has errors") { expect(@errors).to eq(["can't be blank"]) }
              it("does not register") { expect(::User.count).to eq(0) }
            end # describe

            describe "invalid" do
              let(:value) { "foo bar" }
              it("has errors") { expect(@errors).to eq(["is invalid"]) }
              it("does not register") { expect(::User.count).to eq(0) }
            end # describe

            describe "valid" do
              let(:value) { "foobar" }
              it("does not have errors") { expect(@errors).to eq([]) }
              it("registers") { expect(::User.count).to eq(1) }
            end # describe

          end # describe

          describe "config.password_presence = false" do

            before do
              Hello.configure { |config| config.password_presence = false }
              perform
            end

            describe "ignored" do
              let(:value) { nil }
              it("does not have errors") { expect(@errors).to eq([]) }
              it("registers") { expect(::User.count).to eq(1) }
            end # describe

            describe "blank" do
              let(:value) { '' }
              it("does not have errors") { expect(@errors).to eq([]) }
              it("registers") { expect(::User.count).to eq(1) }
            end # describe

            describe "invalid" do
              let(:value) { "foo bar" }
              it("has errors") { expect(@errors).to eq(["is invalid"]) }
              it("does not register") { expect(::User.count).to eq(0) }
            end # describe

            describe "valid" do
              let(:value) { "foobar" }
              it("does not have errors") { expect(@errors).to eq([]) }
              it("registers") { expect(::User.count).to eq(1) }
            end # describe

          end # describe

        end # describe

      end # describe

    end # describe

  end # describe
end # module
