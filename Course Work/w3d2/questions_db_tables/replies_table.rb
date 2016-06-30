require_relative '../questions_db.rb'

class Reply
  attr_reader :id, :author_id, :question_id, :parent_id

  def self.all
    replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless replies.length > 0
    Reply.new(replies.first)
  end

  def self.find_by_user(author_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def author
    User.find_by_id(self.author_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    child_repls = Reply.find_by_question_id(self.question_id)
    child_repls.select { |reply| reply.parent_id == self.id }
  end
end
