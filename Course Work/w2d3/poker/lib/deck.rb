require 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def self.create_deck(suits = Card::SUITS, values = Card::VALUES)
    deck = Deck.new
    suits.each do |suit|
      values.each do |value|
        deck.cards << Card.new(value, suit)
      end
    end
    deck
  end
  # 
  # def make_cards
  #   Card::SUITS.each do |suit|
  #     Card::VALUES.each do |value|
  #       @cards << Card.new(value, suit)
  #     end
  #   end
  # end

  def shuffle!
    @cards.shuffle!
  end
end
