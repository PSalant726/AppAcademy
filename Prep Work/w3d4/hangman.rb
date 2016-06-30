class Hangman
    attr_reader :guesser, :referee, :board
    
    MAX_GUESSES = 10

    def initialize(players)
        @guesser = players[:guesser]
        @referee = players[:referee]
        @guesses_made = 0
    end
    
    def setup
        @secret_word_length = @referee.pick_secret_word
        @guesser.register_secret_length(@secret_word_length)
        @board = [nil] * @secret_word_length
    end
    
    def display_board
        self.update_board
        space = nil
        display_string = ""
        @board.each do |letter|
            if letter.nil?
                space = "[ ]"
            else
                space = "[#{letter}]"
            end
            display_string += space
        end
        puts display_string
    end
    
    def take_turn
        @guess = @guesser.guess(@board)
        @guesses_made += 1
        if __FILE__ == $PROGRAM_NAME
            @guesser.letters_guessed << @guess
        end
        @indices = @referee.check_guess(@guess)
        self.update_board
        @guesser.handle_response(@guess, @indices)
    end
    
    def update_board
        if !@indices.nil?
            @indices.each do |index|
                @board[index.to_i] = @guess.upcase
            end
        end
    end
    
    def play
        puts "Welcome to Hangman, #{@guesser.name} and #{@referee.name}!"
        self.setup
        self.display_board
        until self.win? || @guesses_made == 10
            self.take_turn
            self.display_board
            puts "#{Hangman::MAX_GUESSES - @guesses_made} guesses remaining!"
        end
        puts "Game over!"
        puts "The secret word was '#{@referee.secret_word.upcase}'!"
        if self.win?
            puts "#{@guesser.name} guessed the secret word in #{@guesses_made} guesses! #{@guesser.name} wins!"
        else 
            puts"#{@guesser.name} could not guess the secret word! #{@referee.name} wins!"
        end
    end
    
    def win?
        win = true
        @board.each do |letter|
            if letter.nil?
                win = false
            end
        end
        win
    end
end

class HumanPlayer
    attr_reader :guessed, :name
    attr_accessor :letters_guessed
    
    def initialize(name, dictionary=nil)
        @name = name
        @dictionary = dictionary
        @guesses_made = 0
        @letters_guessed = []
    end
    
    def pick_secret_word
        puts "How many letters in your secret word?"
        @secret_word_length = gets.chomp.to_i
    end
    
    def check_guess(guess)
        indices = []
        puts "Does the letter #{guess.upcase} appear in your secret word?"
        ans = gets.chomp.upcase
        if ans == "YES" || ans == "Y"
            puts "Ok! Enter the spaces where the letter #{guess.upcase} appears in your secret word."
            index = gets.chomp
            if index.include?(",")
                indexes = index.split(", ").map(&:to_i)
                indexes.each { |item| indices << item }
            else
                indices << index.to_i
            end
        else
            puts "Ok! Guessing another letter..."
        end
        indices
    end
    
    def register_secret_length(secret_word_length)
        puts "The secret word has been chosen!"
        puts "It is #{secret_word_length} letters long."
        puts "You have #{Hangman::MAX_GUESSES - @guesses_made} guesses."
    end
    
    def guess(board)
        puts "What letter would you like to guess?"
        @guessed = gets.chomp.downcase
        if @letters_guessed.include?(@guessed)
            puts "You already guessed the letter #{@guessed.upcase}!"
            self.guess
        else
            @guesses_made += 1
            @letters_guessed << @guessed
        end
        @guessed
    end
    
    def handle_response(guess, indices)
        if indices.nil?
            puts "The letter #{guess.upcase} isn't in the secret word."
        else
            puts "The letter #{guess.upcase} is in spaces #{indices}"
        end
    end
end

class ComputerPlayer
    attr_reader :candidate_words, :name, :secret_word
    attr_accessor :letters_guessed
    
    def initialize(name = "Computer",dictionary)
        @name = name
        @dictionary = dictionary
        @letters_guessed = []
    end
    
    def pick_secret_word
        @secret_word = @dictionary.sample
        @secret_word.length
    end
    
    def check_guess(guess)
        @indices = []
        letters = @secret_word.split("")
        letters.each_with_index do |letter,index|
            @indices << index if guess == letter
        end
        @indices
    end
    
    def register_secret_length(secret_word_length)
        @secret_word_length = secret_word_length
        @candidate_words = @dictionary.select do |word|
            word.length == @secret_word_length
        end
    end
    
    def guess(board)
        letter_list = []
        @candidate_words.each do |word|
            word.split("").each { |letter| letter_list << letter }
        end
        board_letters = []
        board.each { |letter| board_letters << letter if !letter.nil? }
        letter_list = letter_list - board_letters
        guessing = self.most_common_letter(letter_list)
        until !@letters_guessed.include?(guessing)
            guessing = self.most_common_letter(letter_list)
        end
        puts "The Computer guesses the letter #{guessing.upcase}!"
        @letters_guessed << guessing
        guessing
    end
    
    def most_common_letter(letter_list)
        current_letter_count = 0
        largest_letter_count = 0
        most_common_letter = ""
        letter_list.each do |letter|
            current_letter_count = letter_list.count(letter)
            if current_letter_count > largest_letter_count
                largest_letter_count = current_letter_count
                most_common_letter = letter
            end
        end
        most_common_letter
    end
    
    def handle_response(guess, indices)
        possible_words = @candidate_words
        @candidate_words = []
        possible_words.each do |word|
            delete = false
            word.split("").each_with_index do |letter, index|
                if indices.include?(index)
                    delete = true if letter != guess
                else
                    delete = true if letter == guess
                end
            end
            @candidate_words << word if !delete
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    players = {
        referee: ComputerPlayer.new(File.readlines("dictionary.txt").map(&:chomp)),
        guesser: HumanPlayer.new("Player1")
    }
    game = Hangman.new(players)
    game.play
end