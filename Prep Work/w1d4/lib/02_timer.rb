class Timer
    attr_accessor :seconds
    
    def initialize
        @seconds = 0
    end
    
    def time_string
        time = {
            hour: @seconds / 3600,
            min: (@seconds / 60) % 60,
            sec: @seconds % 60
        }
        "#{padded(time[:hour])}:#{padded(time[:min])}:#{padded(time[:sec])}"
    end
    
    def padded(num)
        num < 10 ? "0#{num}" : "#{num}"
    end
end