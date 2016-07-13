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

require 'rails_helper'

RSpec.describe Goal, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
