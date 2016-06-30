# == Schema Information
#
# Table name: houses
#
#  id      :integer          not null, primary key
#  address :string
#

class House < ActiveRecord::Base
  validates :address, uniqueness: true, presence: true

  has_many(
    :people,
    class_name: "Person",
    foreign_key: :house_id,
    primary_key: :id
  )
end
