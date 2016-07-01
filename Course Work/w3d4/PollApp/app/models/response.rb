# == Schema Information
#
# Table name: responses
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  ans_choice_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :ans_choice_id, presence: true
  validate :respondent_cannot_answer_twice
  validate :respondent_cannot_be_poll_author

  belongs_to(
    :respondent,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :ans_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def poll_author
    self.question.poll.author
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  private

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.respondent.id)
  end

  def respondent_cannot_answer_twice
    if respondent_already_answered?
      errors[:user_id] << "cannot answer the same question twice"
    end
  end

  def respondent_is_poll_author?
    poll_author.id == self.respondent.id
  end

  def respondent_cannot_be_poll_author
    if respondent_is_poll_author?
      errors[:user_id] << "cannot answer their own poll"
    end
  end
end
