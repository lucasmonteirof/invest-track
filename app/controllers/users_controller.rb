class UsersController < ApplicationController
  def new
    redirect_to root_path if logged_in?

    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:login, :password, :name, :date_of_birth)
    end
end
