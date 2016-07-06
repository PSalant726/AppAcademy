# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  email      :text             not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id
  )

  has_many(
    :users,
    through: :contact_shares,
    source: :user
  )
end
