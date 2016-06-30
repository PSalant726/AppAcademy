# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
    rand_num = Random.new
    answer = rand_num.rand(1..100)
    num_guesses = 1
    guess = nil
    while guess.to_i != answer
        print "guess a number"
        guess = gets.chomp
        print guess
        if guess.to_i == answer
            print "#{answer}"
            print "#{num_guesses}"
        elsif guess.to_i > answer
            print "too high"
        else
            print "too low"
        end
        num_guesses += 1
    end
end

def file_shuffle
    print "Enter a file name"
    file = gets.chomp
    file_array = File.readlines(file)
    file_array_shuffled = file_array.shuffle
    file_shuffled = File.open("#{file}-shuffled.txt", "w") do |f|
          file_array_shuffled.each do |line|
              f.puts line
          end
      end
end