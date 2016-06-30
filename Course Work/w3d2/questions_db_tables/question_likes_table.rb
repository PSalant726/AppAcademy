require_relative '../questions_db.rb'

class QuestionLike
  attr_reader :id

  def self.all
    likes = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    likes.map { |like| QuestionLike.new(like) }
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      LEFT JOIN
        question_likes
        ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL
    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        questions.id, COUNT(question_likes.user_id) AS likers
      FROM
        questions
      LEFT JOIN
        question_likes
        ON questions.id = question_likes.question_id
      WHERE
        questions.id = ?
    SQL
    likes.first.values[1]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      LEFT JOIN
        question_likes
        ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id, COUNT(question_follows.user_id) AS counts
      FROM
        questions
      LEFT JOIN
        question_likes
        ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        counts
    SQL
    most_liked_questions = []
    i = n
    until i == 0
      most_liked_questions = Question.new(questions.shift)
      i -= 1
    end
    most_liked_questions
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @likes = options['likes']
  end
end
