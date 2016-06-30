class Temperature
    # TODO: your code goes here!
    attr_accessor :temp

    def initialize (temp = {:c => ctemp, :f => ftemp})
        @temp = temp
    end

    def in_fahrenheit
        temp[:c] ? temp[:c].to_f * 9 / 5 + 32 : temp[:f].to_f
    end

    def in_celsius
        temp[:f] ? (temp[:f].to_f - 32) * 5 / 9 : temp[:c].to_f
    end
    
    def self.from_celsius(temp)
        self.new ({:c => temp})
    end
    
    def self.from_fahrenheit(temp)
        self.new({:f => temp})
    end
end

class Celsius < Temperature
    attr_accessor :temp
    
    def initialize(ctemp)
        @temp = ctemp
    end
    
    def in_celsius
        @temp
    end
    
    def in_fahrenheit
        @temp.to_f * 9 / 5 + 32
    end
end

class Fahrenheit < Temperature
    def initialize(ftemp)
        @temp = ftemp
    end
    
    def in_fahrenheit
        @temp
    end
    
    def in_celsius
        (@temp.to_f - 32) * 5 / 9
    end
end