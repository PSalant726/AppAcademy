class Board

  DECK = ("2".."10").to_a.concat(["J", "Q", "K", "A"])

  attr_reader :deck, :cards, :grid

  def initialize(grid_size = 16)
    @grid = Array.new(grid_size) { Array.new }
    @deck = DECK
  end

  def generate_cards
    card_values = []
    @cards = []
    until @cards.length == 8
      new_card = Card.new(DECK.sample)
      unless card_values.include?(new_card.face_value)
        card_values << new_card.face_value
        @cards << new_card
      end
    end
    card_values.each do |value|
      @cards << Card.new(value)
    end
    @cards.shuffle!

  end

  def populate
    generate_cards
    @grid.each_with_index do |space, idx|
      space << @cards[idx]
    end
  end

  def render
    @grid.each_with_index do |space,index|
      if index % 4 == 0 && index != 0
        print "\n"
      end
      space[0].display_value
    end
    print "\n"
  end

  def won?
    @grid.each do |space|
      if !space[0].orientation
        return false
      end
    end

    true
  end

  def reveal(guessed_pos)
    @grid[guessed_pos][0].reveal unless @grid[guessed_pos][0].orientation

    @grid[guessed_pos][0].face_value
  end

end
