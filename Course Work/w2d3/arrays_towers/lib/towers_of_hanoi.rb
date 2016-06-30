class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
    @moves = 0
  end

  def play
    puts "Welcome! Towers are numbered from 0 to 2!"
    sleep(1)
    # debugger
    until won?
      begin
        render
        puts "Which tower would you like to draw from?"
        from_tower = gets.chomp
        puts "Which tower would you like to move to?"
        to_tower = gets.chomp
        valid_move?(from_tower.to_i, to_tower.to_i)
        puts "Making your move..."
        sleep(1)
      rescue
        puts "Sorry, that move is invalid. Please select a different move."
        retry
      end
      move(from_tower.to_i, to_tower.to_i)
      unless won?
        puts "Ok! Move made! Time for your next move..."
      end
    end
    render
    puts "You win! Congrats!"
    puts "Moves made: #{@moves}"
  end

  def won?
    # debugger
    towers[0].length == 0 && (towers[1].length == 3 || towers[2].length == 3)
  end

  def move(from_tower, to_tower)
    towers[to_tower].push(towers[from_tower].pop)
    @moves += 1
  end

  def render
    p towers
  end

  def valid_move?(from_tower, to_tower)
    if towers[from_tower][0].nil?
      raise "Source tower is empty!"
    end
    return true if towers[to_tower][0].nil?
    if towers[from_tower][-1] > towers[to_tower][-1]
      raise "Can't place a larger disc on a smaller disc!"
    end
    true
  end

end

if __FILE__ == $PROGRAM_NAME
  game = TowersOfHanoi.new
  game.play
end
