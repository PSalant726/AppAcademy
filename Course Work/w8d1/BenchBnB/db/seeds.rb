# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bench.delete_all
Bench.create(
  name: 'New Apartment',
  description: 'This bench is outside my new apartment!',
  lat: 40.7782659,
  lng: -73.9532544
)
Bench.create(
  name: 'App Academy',
  description: 'This bench is outside App Academy!',
  lat: 40.725070,
  lng: -73.996950
)
Bench.create(
  name: 'Katz\'s Deli',
  description: 'This bench is outside Katz\'s Deli!',
  lat: 40.722380,
  lng: -73.987272
)
Bench.create(
  name: 'Madison Square Garden',
  description: 'This bench is outside MSG!',
  lat: 40.750063,
  lng: -73.992481
)
Bench.create(
  name: 'Museum of Natural History',
  description: 'This bench is outside the NHM!',
  lat: 40.780832,
  lng: -73.972669
)
