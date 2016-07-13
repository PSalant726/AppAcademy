# == Schema Information
#
# Table name: goals
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  future_winner_id :string           not null
#  description      :text
#  public           :boolean          not null
#  complete         :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title Faker::Superhero.power
    future_winner_id 1
    description Faker::Hacker.say_something_smart
    public Faker::Boolean.boolean
    complete Faker::Boolean.boolean
  end
end
