require 'byebug'
require 'rspec'
require 'spec_helper'
require 'towers_of_hanoi'

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  describe "#initialize" do

    it "creates an instance variable 'towers'" do
      expect(game.towers).to_not eq(nil)
    end

    it "initializes a new board" do
      expect(game.towers.length).to eq(3)
    end

    it "populates only one tower" do
      arr = game.towers.select { |tower| tower.length > 0 }
      expect(arr.length ).to eq(1)
    end

    it "populates the tower in descending order" do
      arr = game.towers.select { |tower| tower.length > 0 }
      tower = arr.first
      expect(tower).to eq(tower.sort.reverse)
    end
  end

  describe "#play" do
    it "checks if the game has been won" do
      game.towers[0] = []
      game.towers[1] = [3, 2, 1]
      expect(game).to receive(:won?).and_call_original
      game.play
    end

    it "checks if an attempted move is valid"
    it "renders the board"
    it "moves a disc successfully"

  end

  describe "#move" do
    it "removes the top disc from the source tower" do
      game.move(0, 1)
      expect(game.towers[0].length).to eq(2)
    end

    it "adds removed disc to the destination tower" do
      game.move(0, 1)
      expect(game.towers[1].length).to eq(1)
    end
  end

  describe "#valid_move?" do
    it "returns true if destination tower is empty" do
      expect(game.valid_move?(0, 1)).to be(true)
    end

    it "raises an error if source tower is empty" do
      expect { game.valid_move?(1, 2) }.to raise_error(StandardError)
    end

    it "returns true if source disc is smaller than destination disc" do
      game.move(0, 1)
      expect(game.valid_move?(1, 0)).to be(true)
    end

    it "raises an error if source disc is larger than destination disc" do
      game.move(0, 1)
      expect { game.valid_move?(0, 1) }.to raise_error(StandardError)
    end
  end

  describe "#won?" do
    it "returns false if the starting tower contains all discs" do
      expect(game.won?).to be(false)
    end

    it "returns true if either non-starting tower contains all discs" do
      game.towers[0] = []
      game.towers[1] = [3, 2, 1]
      expect(game.won?).to be(true)
    end

    it "returns false if no tower contains all discs" do
      game.move(0, 1)
      expect(game.won?).to be(false)
    end
  end
end
