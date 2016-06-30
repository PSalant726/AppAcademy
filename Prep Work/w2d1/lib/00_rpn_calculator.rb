class RPNCalculator
    # TODO: your code goes here!
    attr_accessor :stack
    attr_reader :value
    
    def initialize
        @stack = []
        @value = 0
    end
    
    def push(item)
        @stack << item
    end
    
    def plus
        raise("calculator is empty") if @stack.length < 1
        @value = @stack[-2] + @stack[-1]
        2.times { @stack.pop }
        @stack.push(@value)
    end
    
    def minus
        raise("calculator is empty") if @stack.length < 1
        @value = @stack[-2] - @stack[-1]
        2.times { @stack.pop }
        @stack.push(@value)
    end
    
    def times
        raise("calculator is empty") if @stack.length < 1
        @value = @stack[-2].to_f * @stack[-1]
        2.times { @stack.pop }
        @stack.push(@value)
    end
    
    def divide
        raise("calculator is empty") if @stack.length < 1
        @value = @stack[-2].to_f / @stack[-1]
        2.times { @stack.pop }
        @stack.push(@value)
    end
    
    def tokens(string)
        array = string.split(" ")
        array.map! do |item|
            if item == "+" || item == "-" || item == "*" || item == "/"
                item.to_sym
            else
                item.to_i
            end
        end
    end
    
    def evaluate(string)
        stack_items = tokens(string)
        stack_items.each do |item|
            if item == :+
                plus
            elsif item == :-
                minus
            elsif item == :*
                times
            elsif item == :/
                divide
            else
                push(item)
            end
        end
        value
    end
    
    if __FILE__ == $PROGRAM_NAME
        def command_line_interface
            if ARGV.empty?
                puts "No file argument detected. Manual entry required."
                puts "Enter arguments individually, in the desired order of evaluation. Press Enter after each argument."
                puts "When ready to compute, press Enter with no argument presented."
                puts "Please enter first argument:"
                arg = 0
                arg_stack = ""
                until arg == "\n"
                    arg = gets.chomp
                    arg_stack << ("#{arg} ")
                    arg_stack.chomp(" ")
                end
                puts self.evaluate(arg_stack)
            else
                file = ARGV[0]
                puts "File received! Calculating each line as a separate stack..."
                stacks = File.readlines(file)
                vals = []
                stacks.each do |stack|
                    stack.chomp
                    vals << self.evaluate(stack)
                end
                puts vals
            end
        end
        
        calc = RPNCalculator.new
        calc.command_line_interface
    end
end
