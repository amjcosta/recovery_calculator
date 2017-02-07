require 'rails_helper'
require 'spec_helper'

RSpec.describe "LayoutLinks" do
	it "should have a home page at '/'" do
		get '/'
		expect(response.body).to have_title("Home")
	end

	it "should have a Contact page at '/contact'" do
		get '/contact'
		expect(response.body).to have_title("Contact")
	end

	it "should have an About page at '/about'" do
		get '/about'
		expect(response.body).to have_title("About")
	end

	it "should have a signup page at '/signup'" do
		get '/signup'
		expect(response.body).to have_title("Sign up")
	end
end
