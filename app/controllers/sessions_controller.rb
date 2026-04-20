class SessionsController < ApplicationController
  def new
    render :new, status: :ok
  end

  def create
    user = User.find_by(login: session_params[:login])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      head :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def session_params
      params.require(:session).permit(:login, :password)
  end
end
