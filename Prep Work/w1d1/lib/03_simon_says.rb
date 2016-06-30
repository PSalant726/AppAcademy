def echo(word)
    word
end

def shout(word)
    word.upcase
end

def repeat(word, repetitions=2)
    phrase = ""
    repetitions.times{ |repeats| phrase += (word + " ") }
    phrase.strip
end

def start_of_word(word, letters)
    word[0...letters]
end

def first_word(phrase)
    words = phrase.split
    words[0]
end

def titleize(title)
    title_words = title.split
    new_title = ""
    i = 0
    while i < title_words.length
        if i == 0
            new_title += title_words[i].capitalize + " "
        elsif title_words[i].length > 3 && title_words[i] != "over" # With more complex conditions, the second condition on this line could be refactored to read '.include?([array of skippable words]) == false'
            new_title += title_words[i].capitalize + " "
        else
            new_title += title_words[i] + " "
        end
        i += 1
    end
    new_title.strip
end