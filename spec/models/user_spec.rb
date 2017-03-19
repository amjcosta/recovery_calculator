# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#  salt               :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do 
		@user = { 
			:name => "Example User",
			:email => "user@example.com",
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end

	it "should create a new instance given valid attributes" do
		User.create!(@user)
	end

	it "should require a name" do
		no_name_user = User.new(@user.merge(:name => ""))
		expect(no_name_user).not_to be_valid
	end

	it "should not accept names that are too long" do
		long_name = "a" * 51
		long_name_user = User.new(@user.merge(:name => long_name))
		expect(long_name_user).not_to be_valid
	end

	describe "email validations" do
		it "should require an email address" do
			no_email_user = User.new(@user.merge(:email => ""))
			expect(no_email_user).not_to be_valid
		end

		it "should accept valid email addresses" do
			addresses = %w(user@foo.com THE_USER@foo.bar.org first.last@foo.jp)
			addresses.each do |address|
				valid_email_user = User.new(@user.merge(:email => address))
				expect(valid_email_user).to be_valid
			end
		end

		it "should not accept invalid email addresses" do
			addresses = %w(user@foo,com user_at_foo.org example.user@foo.)
			addresses.each do |address|
				invalid_email_user = User.new(@user.merge(:email => address))
				expect(invalid_email_user).not_to be_valid
			end
		end

		it "should not accept a duplicate email address" do
			# Note: we must put a user with a given email address into the database.
			User.create!(@user)
			user_with_duplicate_email = User.new(@user)
			expect(user_with_duplicate_email).not_to be_valid
		end

		it "should not accept email addresses identical up to case" do
			upcased_email = @user[:email].upcase 
			User.create!(@user.merge(:email => upcased_email))
			user_with_duplicate_email = User.new(@user)
			expect(user_with_duplicate_email).not_to be_valid
		end
	end

	describe "password validations" do
		it "should require a password" do
			no_password_user = User.new(@user.merge(:password => "",:password_confirmation => ""))
			expect(no_password_user).not_to be_valid
		end

		it "should require a matching password confirmation" do
			invalid_password_user = User.new(@user.merge(:password_confirmation => "invalid"))
			expect(invalid_password_user).not_to be_valid
		end

		it "should reject short passwords" do
			short = "a" * 5
			short_password_user = User.new(@user.merge(:password => short,:password_confirmation => short))
			expect(short_password_user).not_to be_valid
		end

		it "should reject long passwords" do
			long = "a" * 41
			long_password_user = User.new(@user.merge(:password => long,:password_confirmation => long))
			expect(long_password_user).not_to be_valid
		end
	end

	describe "password encryption" do
		before(:each) do
			@encrypt_user = User.create!(@user)
		end

		it "should have an encrypted password attribute" do
			expect(@encrypt_user).to respond_to(:encrypted_password)
		end

		it "should set the encrypted password" do
			expect(@encrypt_user.encrypted_password).not_to be_blank
		end

		describe "has_password? method" do
			it "should be true if the passwords match" do
				expect(@encrypt_user.has_password?(@user[:password])).to be_truthy
			end

			it "should be false if the passwords don't match" do
				expect(@encrypt_user.has_password?("invalid")).to be_falsy
			end
		end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@user[:email],"wrongpass")
        expect(wrong_password_user).to be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("wrong@example.com",@user[:password])
        expect(nonexistent_user).to be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@user[:email],@user[:password])
        expect(matching_user).to eq(@encrypt_user)
      end
    end
	end
end
