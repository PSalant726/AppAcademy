class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      log_in(@user)
      flash[:errors] = ["Welcome, #{@user.username}!"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password!"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_sessions_url
  end
end
