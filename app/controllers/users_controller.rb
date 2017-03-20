class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@title = "Sign up"
  	User.create(user_params)
  end

  private

  def user_params
  	# :name, :email
  	params.permit(:name, :email)
  end
end
