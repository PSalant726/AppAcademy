require 'rspec'
require 'spec_helper'
require 'deck'

describe 'Deck' do
  let(:deck) { Deck.new }
  let(:fac_deck) { Deck.create_deck }

  describe "#initialize" do
    it "creates a 'cards' instance variable" do
      expect(deck.cards).to_not eq(nil)
    end
  end

  describe "::create_deck" do

    it "creates 52 Card objects in 'cards'" do
      expect(fac_deck.cards.select { |card| card.is_a?(Card)}.count).to eq(52)
    end

    it "creates 13 Card objects of a single suit" do
      expect(fac_deck.cards.select { |card| card.suit == :S }.count).to eq(13)
    end

    it "creates 4 Card objects of a single value" do
      expect(fac_deck.cards.select { |card| card.value == :A }.count).to eq(4)
    end
  end

  describe "#shuffle!" do
    it "shuffles the deck" do
      bef_first_card = fac_deck.cards[0]
      fac_deck.shuffle!
      aft_first_card = fac_deck.cards[0]
      expect(bef_first_card).to_not eq(aft_first_card)
    end
  end
end
