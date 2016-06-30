# Create an array of all the seed within a given house.

# app/models/gardener.rb
class Gardener
  # ...
  belongs_to :house,
    foreign_key: :house_id,
    primary_key: :id,
    class_name: :House

  has_many :plants,
    foreign_key: :gardener_id,
    primary_key: :id,
    class_name: :Gardener
  # ...
end


# app/models/plant.rb
class Plant
  # ...
  belongs_to :gardener,
    foreign_key: :gardener_id,
    primary_key: :id,
    class_name: :Gardener

  has_many :seeds,
    foreign_key: :plant_id,
    primary_key: :id,
    class_name: :Seed
  # ...
end



# app/models/seed.rb
class Seed
  # ...
  belongs_to :plant,
    foreign_key: :plant_id,
    primary_key: :id,
    class_name: :Plant
  # ...
end


# app/models/house.rb
class House
  has_many :gardeners,
    foreign_key: :house_id,
    primary_key: :id,
    class_name: :Gardener

  has_many :plants,
    through: :gardeners,
    source: :plants
  # ...

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    # TODO: your code here
  end
end
