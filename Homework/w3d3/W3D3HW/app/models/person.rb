# == Schema Information
#
# Table name: people
#
#  id       :integer          not null, primary key
#  name     :string
#  house_id :integer
#

class Person < ActiveRecord::Base
  validates :house_id, uniqueness: true, presence: true

  belongs_to(
    :house,
    class_name: "House",
    foreign_key: :house_id,
    primary_key: :id
  )
end
