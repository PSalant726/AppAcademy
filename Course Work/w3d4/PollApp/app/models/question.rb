# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def n_plus_one_results
    results_hash = {}

    answer_choices.each do |choice|
      results_hash[choice.text] = choice.responses.length
    end

    results_hash
  end

  def results
    results_hash = {}
    choices_with_responses = answer_choices.includes(:responses)

    choices_with_responses.each do |choice_responses|
      results_hash[choice_responses.text] = choice_responses.responses.length
    end

    results_hash
  end
