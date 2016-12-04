require 'rails_helper'
require 'spec_helper'
include Capybara::RSpecMatchers

RSpec.describe PagesController, type: :controller do
  render_views

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  it "should have the right title" do
  	get :home
  	expect(response.body).to have_title("Eating Disorder Recovery Calculator | Home")
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
  end

  it "should have the right title" do
  	get :contact
  	expect(response.body).to have_title("Eating Disorder Recovery Calculator | Contact")
  end

  describe "GET #about" do
  	it "returns http success" do
  	  get :about
  	  expect(response).to have_http_status(:success)
  	end
  end

  it "should have the right title" do
  	get :about
  	expect(response.body).to have_title("Eating Disorder Recovery Calculator | About")
  end
end
