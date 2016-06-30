def translate(phrase)
    words = phrase.split
    pig_latin_words = []
    vowels = ["a", "e", "i", "o", "u"]
    i = 0
    while i < words.length
        if vowels.include?(words[i][0]) && vowels.include?(words[i][1]) == false
            pig_latin_words[i] = words[i] + "ay"
        elsif vowels.include?(words[i][0]) && vowels.include?(words[i][1])
            pig_latin_words[i] = words[i] + "ay"
        elsif words[i].include?("qu")
            pig_latin_words[i] = words[i][words[i].index("qu") + 2..-1] + words[i][0..words[i].index("qu") + 1]  + "ay"
        elsif vowels.include?(words[i][0]) == false && vowels.include?(words[i][1]) == false && vowels.include?(words[i][2])
            pig_latin_words[i] = words[i][2..-1] + words[i][0..1] + "ay"
        elsif vowels.include?(words[i][0]) == false && vowels.include?(words[i][1]) == false && vowels.include?(words[i][2]) == false && vowels.include?(words[i][3])
            pig_latin_words[i] = words[i][3..-1] + words[i][0..2] + "ay"
        else
            pig_latin_words[i] = words[i][1..-1] + words[i][0] + "ay"
        end
        i += 1
    end
    pig_latin_words.join(" ").strip
end