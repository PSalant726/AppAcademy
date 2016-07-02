require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    @columns = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{table_name}
    SQL
    @columns.map! { |col| col.to_sym }
  end

  def self.finalize!
    columns.each do |column|
      define_method(column) do
        attributes[column]
      end
      define_method((column.to_s + "=").to_sym) do |value|
        attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name.nil? ? self.to_s.tableize : @table_name
  end

  def self.all
    rows = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    self.parse_all(rows)
  end

  def self.parse_all(results)
    obs = []
    results.each do |result|
      obs << self.new(result)
    end
    obs
  end

  def self.find(id)
    rows = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL
    self.parse_all(rows).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes.nil? ? @attributes = {} : @attributes
  end

  def attribute_values
    self.class.columns.map { |column| self.send("#{column}") }
  end

  def insert
    col_names = self.class.columns.drop(1).map(&:to_s).join(",")
    question_marks = (["?"] * self.class.columns.drop(1).count).join(",")
    vals = attribute_values.drop(1)
    rows = DBConnection.execute(<<-SQL, *vals)
      INSERT INTO
        #{self.class.table_name}(#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update

    rows = DBConnection.execute(<<-SQL)
      UPDATE
        table_name
      SET
        col1 = ?, col2 = ?, col3 = ?
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? self.insert : self.update
  end
end
