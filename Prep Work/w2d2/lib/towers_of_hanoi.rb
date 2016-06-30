# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
    attr_reader :towers
    
    def initialize
        @towers = [[3,2,1],[],[]]
    end
    
    def move(from_tower, to_tower)
        @towers[to_tower].push(@towers[from_tower][-1])
        @towers[from_tower].pop
    end
    
    def valid_move?(from_tower, to_tower)
        if @towers[from_tower][0].nil? || from_tower.nil? || to_tower.nil?
            false
        else
            if @towers[to_tower][-1].nil?
                true
            elsif @towers[from_tower][-1] > @towers[to_tower][-1]
                false
            else
                true
            end
        end
    end
    
    def won?
        if @towers[0].length == 0 && (@towers[1].length == 3 || @towers[2].length == 3)
            true
        else
            false
        end
    end
    
    def render
        puts @towers.to_s
    end
    
    def play
        won = false
        move_valid = false
        puts "Welcome! Towers are numbered from 0 to 2!"
        until won
            until move_valid
                from_tower = nil
                to_tower = nil
                self.render
                puts "Which tower would you like to draw from?"
                from_tower = gets.chomp
                puts "Which tower would you like to move to?"
                to_tower = gets.chomp
                move_valid = self.valid_move?(from_tower.to_i, to_tower.to_i)
                if !move_valid
                    puts "Sorry, that move is invalid. Please select a different move."
                else
                    puts "Making your move..."
                end
            end
            self.move(from_tower.to_i, to_tower.to_i)
            won = self.won?
            if won
                self.render
                puts "You win! Congrats!"
            else
                puts "Ok! Move made! Time for your next move..."
                move_valid = false
            end
        end
    end
    
    if __FILE__ == $PROGRAM_NAME
        game = TowersOfHanoi.new
        game.play
    end
end