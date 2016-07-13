class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    logout
    unless @user.destroy
      flash[:errors] = @user.errors.full_messages
    end
    redirect_to goals_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
