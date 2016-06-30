# Count all of the tracks on each album by a given artist.

# app/models/album.rb
class Album
  # ...
  belongs_to :artist,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :Artist
  # ...
end


# app/models/artist.rb
class Artist
  has_many :albums,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :Album
  # ...

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      albums[album.name] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
  end
end
