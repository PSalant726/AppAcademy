class SubsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_moderator_to_change_sub, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update
      render :show
    else
      flash.now[:errors] = ["Unable to make that change."]
      render :show
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    flash.now[:errors] = ["The sub '#{@sub.title}' has been deleted!'"]
    render :index
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_moderator_to_change_sub
    @sub = Sub.find(params[:id])
    unless @sub.moderator == current_user
      flash[:errors] = ["You must be this sub's moderator to make changes."]
      redirect_to sub_url(@sub)
    end
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["You must be logged in to do that!"]
      redirect_to subs_url
    end
  end
end
