# == Schema Information
#
# Table name: goals
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  future_winner_id :integer          not null
#  description      :text
#  public           :boolean          not null
#  complete         :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :title, :future_winner_id, presence: true
  validates_inclusion_of :public, :complete, in: [true, false]
  belongs_to(
    :future_winner,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :future_winner_id
  )
end
