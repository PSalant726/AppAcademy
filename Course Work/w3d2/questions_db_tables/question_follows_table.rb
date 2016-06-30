require_relative '../questions_db.rb'

class QuestionFollow
  attr_reader :id

  def self.all
    question_follows = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    question_follows.map { |question_follow| QuestionFollow.new(question_follow) }
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      LEFT JOIN
        question_follows
        ON users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?
    SQL
    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      LEFT JOIN
        question_follows
        ON questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id, COUNT(question_follows.user_id) AS counts
      FROM
        questions
      LEFT JOIN
        question_follows
        ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        counts
    SQL
    most_followed_questions = []
    i = n
    until i == 0
      most_followed_questions = Question.new(questions.shift)
      i -= 1
    end
    most_followed_questions
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
