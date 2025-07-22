class HomeController < ApplicationController
  def index
    if logged_in?
      head :ok
    else
      redirect_to login_path
    end
  end
end
