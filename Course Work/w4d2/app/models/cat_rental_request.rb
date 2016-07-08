# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true

  def overlapping_requests
    CatRentalRequest.where(
      "NOT (? > end_date OR ? < start_date) AND id != ?",
      self.start_date, self.end_date, self.id
    )
  end

  def overlapping_approved_requests
    overlapping_requests.where("cat_id = ? AND status = 'APPROVED'", self.cat_id)
  end

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

end
