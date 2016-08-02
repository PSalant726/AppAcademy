# == Schema Information
#
# Table name: benches
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  lat         :float
#  lng         :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seating     :integer
#

class Bench < ActiveRecord::Base
  validates :name, uniqueness: true

  def self.in_bounds(bounds)
    benches_in_bounds = [];
    self.all.each do |bench|
      if bench.lat >= bounds["southWest"]["lat"].to_f &&
        bench.lat <= bounds["northEast"]["lat"].to_f &&
        bench.lng >= bounds["southWest"]["lng"].to_f &&
        bench.lng <= bounds["northEast"]["lng"].to_f
        benches_in_bounds << bench
      end
    end
    benches_in_bounds
  end
end
