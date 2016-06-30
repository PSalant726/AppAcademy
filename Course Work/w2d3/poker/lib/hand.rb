require 'card'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def straight_flush?

  end

  def four_of_a_kind?

  end

  def full_house?

  end

  def flush?
    Card::SUITS.each do |suit|
      return true if cards.all? { |card| card.suit == suit } &&
        cards.length == 5
    end
    false
  end

  def straight?

  end

  def three_of_a_kind?

  end

  def two_pair?

  end

  def pair?
    card_values = []
    cards.each { |card| card_values << card.value }
    card_values.uniq.length < 5
  end

  def high_card

  end
end
