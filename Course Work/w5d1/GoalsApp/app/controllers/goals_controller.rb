class GoalsController < ApplicationController
  before_action :redirect_unless_logged_in

  def index
    @goals = Goal.all
  end

  def new
    render :new
  end

end
