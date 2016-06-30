require 'rspec'
require 'spec_helper'
require 'card'

describe 'Card' do
  let(:card) { Card.new(:A, :S) }

  describe "#initialize" do
    it "creates a 'suit' instance variable" do
      expect(card.suit).to be(:S)
    end

    it "creates a 'value' instance variable" do
      expect(card.value).to be(:A)
    end

    it "raises an error if value argument is wrong" do
      expect { Card.new(1, :S) }.to raise_error(StandardError)
    end

    it "raises an error if suit argument is wrong" do
      expect { Card.new(:A, :L) }.to raise_error(StandardError)
    end
  end
end
