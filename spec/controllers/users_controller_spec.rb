require 'rails_helper'
require 'spec_helper'
include Capybara::RSpecMatchers

RSpec.describe UsersController, type: :controller do
	render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  it "should have the right title" do
  	get :new
  	expect(response.body).to have_title("Sign up")
  end

end
