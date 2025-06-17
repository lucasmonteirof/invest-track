class SessionsController < ApplicationController
  def new
    render :new, status: :ok
  end

  def create
    user = User.find_by(login: params[:login])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      head :ok
    else
      head :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
