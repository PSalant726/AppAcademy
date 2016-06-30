# Create a hash with each bus route as a key and an array of bus
# drivers as the corresponding value.
# E.g. -
# {
#   '47' => ['Joan Lee', 'Charlie McDonald', 'Kevin Quashie'],
#   'N Judah' => ['Ed Michaels', 'Lisa Frank', 'Sharla Alegria']
# }

# app/models/driver.rb
class Driver
  # ...
  belongs_to :routes,
    foreign_key: :route_id,
    primary_key: :id,
    class_name: :Route
  # ...
end


# app/models/route.rb
class Route
  has_many :drivers,
    foreign_key: :route_id,
    primary_key: :id,
    class_name: :Driver

  has_many :buses,
    foreign_key: :route_id,
    primary_key: :id,
    class_name: :Bus
  # ...
end


# app/models/bus.rb
class Bus
  belongs_to :routes,
    foreign_key: :route_id,
    primary_key: :id,
    class_name: :Route
  # ...

  def n_plus_one_drivers
    routes = self.routes
    all_drivers = {}
    routes.each do |route|
      drivers = []
      route.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[route] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # TODO: your code here
  end
end
