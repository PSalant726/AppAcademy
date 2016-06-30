# n!
def first_anagram_phase_alpha?(anagram_word, anagram)
  anagram_word.split('').permutation.to_a.map(&:join).include?(anagram)
end

# n
def first_anagram_phase_bravo?(first_word, second_word)
  second_word_letters = second_word.split('')
  first_word.split('').each do |letter|
    index_of_second_word_letter = second_word_letters.find_index(letter)
    return false if index_of_second_word_letter.nil?
    second_word_letters.delete_at(index_of_second_word_letter)
  end

  second_word_letters.empty?
end

# n*log(n)
def first_anagram_phase_charlie?(first_word, second_word)
  first_word.split("").sort == second_word.split("").sort
end

# n
def first_anagram_phase_delta?(first_word, second_word)
  count_occurances_of_letters_in(first_word) ==
  count_occurances_of_letters_in(second_word)
end

def count_occurances_of_letters_in(word)
  counter =  Hash.new(0)
  word.split('').each do |letter|
    counter[letter] += 1
  end
  counter
end

if __FILE__ == $PROGRAM_NAME
  puts "PHASE ALPHA SUCCESS?"
  puts first_anagram_phase_alpha?("hell",   "lleh")
  puts "\nPHASE BRAVO SUCCESS?"
  puts first_anagram_phase_bravo?("hell",   "lleh")
  puts first_anagram_phase_bravo?("hell",   "llADFASDFeh")? "NO" : "HELL YEAHHHH!"
  puts "\nPHASE CHARLIE SUCCESS?"
  puts first_anagram_phase_charlie?("hell", "lleh")
  puts "\nPHASE DELTA SUCCESS?"
  puts first_anagram_phase_delta?("hell", "lleh")? "OORAH!!!!" : "you let us down :-("
end
