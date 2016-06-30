DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  question_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  likes BOOLEAN NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Jimmy', 'DiColandrea'),
  ('Phil', 'Salant');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How much could a woodchuck chuck?', 'Seriously, how much?', (SELECT id FROM users WHERE fname = 'Jimmy') ),
  ('What''s the worst that could happen?', 'How much coffee is too much coffeeee?', (SELECT id FROM users WHERE fname = 'Phil'));

INSERT INTO
  question_follows(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'How much could a woodchuck chuck?'), (SELECT id FROM users WHERE fname = 'Phil')),
  ((SELECT id FROM questions WHERE title = 'What''s the worst that could happen?'), (SELECT id FROM users WHERE fname = 'Jimmy'));

INSERT INTO
  replies(question_id, parent_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'How much could a woodchuck chuck?'), NULL,(SELECT id FROM users WHERE fname = 'Phil'), 'That''s a dumb question!'),
  ((SELECT id FROM questions WHERE title = 'How much could a woodchuck chuck?'), (SELECT id FROM replies WHERE body = 'That''s a dumb question!'), (SELECT id FROM users WHERE fname = 'Jimmy'), 'Leave me alone!');

INSERT INTO
  question_likes(question_id, user_id, likes)
VALUES
  ((SELECT id FROM questions WHERE title = 'How much could a woodchuck chuck?'), (SELECT id FROM users WHERE fname = 'Phil') , 1);
