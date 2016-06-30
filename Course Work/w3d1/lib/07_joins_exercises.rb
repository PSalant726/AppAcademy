# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  INNER JOIN
    castings
    ON movies.id = castings.movie_id
  INNER JOIN
    actors
    ON actors.id = castings.actor_id
  WHERE
    actors.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  INNER JOIN
    castings
    ON movies.id = castings.movie_id
  INNER JOIN
    actors
    ON actors.id = castings.actor_id
  WHERE
    actors.name = 'Harrison Ford'
    AND castings.ord != 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT
    m.title, a.name
  FROM
    movies m
  INNER JOIN
    castings c
    ON m.id = c.movie_id
  INNER JOIN
    actors a
    ON a.id = c.actor_id
  WHERE
    m.yr = '1962'
    AND c.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT
    *
  FROM (
    SELECT
      m.yr, COUNT(m.title) AS counter
    FROM
      movies m
    INNER JOIN
      castings c
      ON m.id = c.movie_id
    INNER JOIN
      actors a
      ON a.id = c.actor_id
    WHERE
      a.name = 'John Travolta'
    GROUP BY
      m.yr
  ) AS co
  WHERE
    co.counter >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  SELECT
    julie_movies.julie_titles, ac.name
  FROM (
    SELECT
      m.title AS julie_titles, m.id AS julie_ids
    FROM
      movies m
    INNER JOIN
      castings c
      ON m.id = c.movie_id
    INNER JOIN
      actors a
      ON a.id = c.actor_id
    WHERE
      a.name = 'Julie Andrews'
    ) AS julie_movies
  INNER JOIN
    castings ca
    ON ca.movie_id = julie_movies.julie_ids
  INNER JOIN
    actors ac
    ON ac.id = ca.actor_id
  WHERE
    ca.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  SELECT
    star_cnt.name
  FROM
    (SELECT
      a.name AS name, COUNT(m.title) AS count
    FROM
      movies m
    INNER JOIN
      castings c
      ON c.movie_id = m.id
    INNER JOIN
      actors a
      ON a.id = c.actor_id
    WHERE
      c.ord = 1
    GROUP BY
      a.name) as star_cnt
  WHERE
    star_cnt.count >= 15
  ORDER BY
    star_cnt.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)

  SELECT
    m.title, COUNT(a.name) AS actor_count
  FROM
    movies m
  INNER JOIN
    castings c
    ON c.movie_id = m.id
  INNER JOIN
    actors a
    ON a.id = c.actor_id
  WHERE
    m.yr = 1978
  GROUP BY
    m.title
  ORDER BY
    actor_count DESC, m.title
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  SELECT
    ac.name
  FROM
    (SELECT
      m.title AS art_titles, m.id AS art_id
    FROM
      movies m
    INNER JOIN
      castings c
      ON m.id = c.movie_id
    INNER JOIN
      actors a
      ON a.id = c.actor_id
    WHERE
      a.name = 'Art Garfunkel'
    ) AS art_movies
  INNER JOIN
    castings ca
    ON ca.movie_id = art_movies.art_id
  INNER JOIN
    actors ac
    ON ac.id = ca.actor_id
  WHERE
    ac.name != 'Art Garfunkel'
  GROUP BY
    ac.name



  SQL
end
