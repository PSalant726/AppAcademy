# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  color       :string
#  sex         :string(1)        not null
#  description :text
#  birth_date  :date
#

class Cat < ActiveRecord::Base
  validates :color, inclusion: { in: ["black", "orange"],
    message: "%{value} is not a valid color" }
  validates :name, :sex, presence: true
  validates :sex, length: { is: 1 }

  has_many(
    :rental_requests,
    dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id
  )
end
