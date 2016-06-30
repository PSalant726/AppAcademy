class Dictionary
    # TODO: your code goes here!
    attr_reader :entries
    
    def initialize
        @entries = {}
    end

    def add(entry)
        if entry.class == Hash
            word = entry.keys[0]
            definition = entry.values[0]
            @entries[word] = definition
        elsif entry.class == String
            @entries[entry] = nil
        end
    end
    
    def keywords
        @entries.keys.sort
    end
    
    def include?(word)
        @entries.key?(word)
    end
    
    def find(word)
        matches = {}
        @entries.each do |key, value|
            key.start_with?(word) ? matches[key] = value : nil
        end
        matches
    end
    
    def printable
        keys = self.keywords
        results = ""
        keys.each { |word| results << "[#{word}] \"#{@entries[word]}\"\n" }
        results.chop
    end
end