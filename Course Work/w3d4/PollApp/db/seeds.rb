# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  #Make new users
  User.destroy_all
  User.create(name: "Gordon")
  User.create(name: "Phil")
  User.create(name: "Fred")
  User.create(name: "Dan")
  gordo = User.first
  phil = User.all[1]
  fred = User.all[2]
  dan = User.last

  #Make new polls
  Poll.destroy_all
  Poll.create(title: "Favorite color", author_id: gordo.id)
  Poll.create(title: "Is it Friday", author_id: phil.id)
  color_poll = Poll.first
  friday_poll = Poll.last

  #Make new questions
  Question.destroy_all
  Question.create(poll_id: color_poll.id, text: "What is your favorite color?")
  Question.create(poll_id: color_poll.id, text: "What is your second favorite color?")
  Question.create(poll_id: friday_poll.id, text: "Is it Friday?")
  Question.create(poll_id: friday_poll.id, text: "Are you sure????")
  fav_color_q = Question.all[0]
  second_fav_color_q = Question.all[1]
  is_friday_q = Question.all[2]
  are_you_sure_q = Question.all[3]


  #Make new answer choices
  AnswerChoice.destroy_all
  AnswerChoice.create(question_id: fav_color_q.id, text: "Red")
  AnswerChoice.create(question_id: fav_color_q.id, text: "Blue")
  AnswerChoice.create(question_id: fav_color_q.id, text: "Green")
  AnswerChoice.create(question_id: second_fav_color_q.id, text: "Red")
  AnswerChoice.create(question_id: second_fav_color_q.id, text: "Blue")
  AnswerChoice.create(question_id: second_fav_color_q.id, text: "Green")
  AnswerChoice.create(question_id: is_friday_q.id, text: "Yes")
  AnswerChoice.create(question_id: is_friday_q.id, text: "No")
  AnswerChoice.create(question_id: are_you_sure_q.id, text: "Definitely!")
  AnswerChoice.create(question_id: are_you_sure_q.id, text: "Helllllll naw!")
  fred_fav_color_choice = AnswerChoice.first
  dan_fav_color_choice = AnswerChoice.all[2]
  phil_fav_color_choice = AnswerChoice.all[2]
  phil_sec_fav_color_choice = AnswerChoice.all[3]
  gordo_friday_choice = AnswerChoice.all[7]

  #Make new responses
  Response.destroy_all
  Response.create(user_id: phil.id, ans_choice_id: phil_fav_color_choice.id)
  Response.create(user_id: gordo.id, ans_choice_id: gordo_friday_choice.id)
  Response.create(user_id: fred.id, ans_choice_id: fred_fav_color_choice.id)
  Response.create(user_id: dan.id, ans_choice_id: dan_fav_color_choice.id)
  Response.create(user_id: phil.id, ans_choice_id: phil_sec_fav_color_choice.id)
