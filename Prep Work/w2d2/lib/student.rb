class Student
    attr_reader :first_name, :last_name, :courses
    attr_accessor :enroll
    
    def initialize (first_name, last_name)
        @first_name = first_name
        @last_name = last_name
        @courses = []
    end
    
    def name
        first_name + " " + last_name
    end
    
    def enroll(new_course)
        if !@courses.include?(new_course)
            @courses.each do |course|
                if new_course.conflicts_with?(course)
                    raise ("Conflic Error!")
                end
            end
            @courses << new_course
            new_course.students << self
        end
    end
    
    def course_load
        course_hash = Hash.new{0}
        @courses.each do |course|
            course_hash[course.department] += course.credits
        end
        course_hash
    end
end