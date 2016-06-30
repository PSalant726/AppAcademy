require_relative 'employee'

class Manager < Employee
  attr_reader :employees

  def initialize(name, salary, title, manager)
    super
    @employees = []
  end

  def bonus(multiplier)
    total_of_salaries = 0
    return self.salary if self.employees.nil?
    employees.each do |employee|
      if employee.is_a?(Manager)
        total_of_salaries += employee.salary
        total_of_salaries += employee.bonus(1)
      else
        total_of_salaries += employee.salary
      end
    end
    total_of_salaries * multiplier
  end

end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new('Ned', 1_000_000, "founder", nil)
  darren = Manager.new('Darren', 78_000, 'manager', ned)
  shawna = Employee.new('Shawna', 12_000, 'TA', darren)
  david = Employee.new('David', 10_000, 'TA', darren)
  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
end

# Name	Salary	Title	Boss
# Ned	$1,000,000	Founder	nil
# Darren	$78,000	TA Manager	Ned
# Shawna	$12,000	TA	Darren
# David	$10,000	TA	Darren
# then we should have bonuses like this:
#
# ned.bonus(5) # => 500_000
# darren.bonus(4) # => 88_000
# david.bonus(3) # => 30_000
