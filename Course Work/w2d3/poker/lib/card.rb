class Card
  attr_reader :suit, :value

  SUITS = [:S, :D, :H, :C]

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]

  def initialize(value, suit)
    raise "invalid suit" unless SUITS.include?(suit)
    raise "invalid value" unless VALUES.include?(value)
    @value = value
    @suit = suit
  end
end
