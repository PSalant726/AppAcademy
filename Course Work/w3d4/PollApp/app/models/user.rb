# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :authored_polls,
    class_name: :Poll,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: :Response,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :answered_questions,
    through: :responses,
    source: :question
  )

  has_many(
    :participated_polls,
    through: :answered_questions,
    source: :poll
  )

end
