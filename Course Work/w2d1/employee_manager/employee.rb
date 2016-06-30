class Employee
  attr_accessor :salary, :title
  attr_reader :name, :employees

  def initialize(name, salary, title, manager)
    @name = name
    @salary = salary
    @title = title
    @manager = manager
    @employees = nil
    unless manager.nil?
      manager.employees << self
    end
  end

  def bonus(multiplier)
    salary * multiplier
  end
end
