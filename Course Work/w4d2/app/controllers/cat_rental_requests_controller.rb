class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all

    render :index
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to cat_rental_requests_url
    else
      render :new
    end

  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :status)
  end

end
