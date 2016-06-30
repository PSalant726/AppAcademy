require 'rspec'
require 'spec_helper'
require 'hand'
require 'card'

describe 'Hand' do
  let(:hand) { Hand.new }

  describe "#initialize" do
    it "create an instance variable 'cards'" do
      expect(hand.cards).to_not eq(nil)
    end
  end

  describe "#straight_flush?" do
    it "returns true if the hand contains a straight flush" do
      expect(hand.straight_flush?).to be(true)
    end

    it "returns false if the hand does not contain not a straight flush" do
      expect(hand.straight_flush?).to be(false)
    end

  end

  describe "#four_of_a_kind?" do
    it "returns true if the hand contains a four-of-a-kind" do
      expect(hand.four_of_a_kind?).to be(true)
    end

    it "returns false if the hand does not contain a four-of-a-kind" do
      expect(hand.four_of_a_kind?).to be(false)
    end

  end

  describe "#full_house?" do
    it "returns true if the hand contains a full house" do
      expect(hand.full_house?).to be(true)
    end

    it "returns false if the hand does not contain a full house" do
      expect(hand.full_house?).to be(false)
    end

  end

  describe "#flush?" do
    it "returns true if the hand contains a flush" do
      expect(hand.flush?).to be(true)
    end

    it "returns false if the hand does not contain a flush" do
      expect(hand.flush?).to be(false)
    end

  end

  describe "#straight?" do
    it "returns true if the hand contains a straight" do
      expect(hand.straight?).to be(true)
    end

    it "returns false if the hand does not contain a straight" do
      expect(hand.straight?).to be(false)
    end

  end

  describe "#three_of_a_kind?" do
    it "returns true if the hand contains a three-of-a-kind" do
      expect(hand.three_of_a_kind?).to be(true)
    end

    it "returns false if the hand does not contain a three-of-a-kind" do
      expect(hand.three_of_a_kind?).to be(false)
    end

  end

  describe "#two_pair?" do
    it "returns true if the hand contains a two-pair" do
      expect(hand.two_pair?).to be(true)
    end

    it "returns false if the hand does not contain a two-pair" do
      expect(hand.two_pair?).to be(false)
    end

  end

  describe "#pair?" do
    it "returns true if the hand contains a pair" do
      5.times { hand.cards << Card.new(:A, :S) }
      expect(hand.pair?).to be(true)
    end

    it "returns false if the hand does not contain a pair" do
      expect(hand.pair?).to be(false)
    end

  end

  describe "#high_card" do
    it "returns the highest value card in the hand" do

    end

  end

  describe "#calculate_hand" do
    it "returns the value of the hand" do

    end
  end

end
