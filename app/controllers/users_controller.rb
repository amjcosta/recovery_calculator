class UsersController < ApplicationController
  def new
  	@title = "Sign up"
  	User.create(user_params)
  end

  private

  def user_params
  	# :name, :email
  	params.require(:user).permit(:name, :email)
  end
end
