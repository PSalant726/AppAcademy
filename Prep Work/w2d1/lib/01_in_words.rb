class Fixnum
    def word_pieces(key, value)
        words = {0 => %w[one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen],
            1 => %w[ten twenty thirty forty fifty sixty seventy eighty ninety],
            2 => %w[thousand million billion trillion]
        }
        words[key][value]
    end
    
    def in_words
        return "zero" if self == 0
        total_in_words = []
        remaining = self
        group_of_three = 1000
        counter = 0
        while remaining > 0
            huns_ones = remaining % group_of_three
            three_digs = huns_ones / (group_of_three / 1000)
            number_array = []
            ones = three_digs % 10
            tens = three_digs % 100 - ones
            hundreds = three_digs % 1000 - tens - ones
            number_array << "#{word_pieces(0, (hundreds / 100 - 1))} hundred" if hundreds > 0
            if (11..19).include?(tens + ones)
                number_array << word_pieces(0, (tens + ones - 1))
            else
                number_array << word_pieces(1, (tens / 10 - 1)) if tens > 0
                number_array << word_pieces(0, (ones - 1 )) if ones > 0
            end
            number_array << word_pieces(2, (counter - 1)) unless three_digs == 0 || counter == 0
            
            group_of_three *= 1000
            counter += 1
            remaining -= huns_ones
            total_in_words.unshift(number_array.join(" ")) unless number_array.length == 0
        end
        total_in_words.join(" ")
    end
end