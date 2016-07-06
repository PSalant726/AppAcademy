class ContactSharesController < ApplicationController
  def index
    @contact_shares = ContactShare.all

    render json: @contact_shares
  end

  def create
    contact_share = ContactShare.new(contact_share_params)

    if contact_share.save
      render json: contact_share
    else
      render json: contact_shares.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    contact_share = ContactShare.find(params[:id])

    if contact_share.destroy
      render json: contact_share
    else
      render json: contact_shares.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
