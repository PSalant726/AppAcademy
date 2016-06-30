require 'rspec'
require 'spec_helper'
require 'array_exercises'

describe "Array#my_uniq" do
  let(:arr) { [1, 5, 1, 4, 5] }

  it "removes duplicate values from the array on which it's called" do
    expect(arr.my_uniq).to eq(arr.uniq)
  end

  it "creates a new array" do
    expect(arr.my_uniq.object_id).to_not eq(arr.object_id)
  end

  it "returns unique values in the order they appear" do
    expect(arr.my_uniq).to eq([1, 5, 4])
  end

  it "doesn't call built in Array#uniq method" do
    expect(arr).not_to receive(:uniq)
    arr.my_uniq
  end
end

describe "Array#two_sum" do
  let (:arr) { [-1, 0, 2, -2, 1] }
  it "finds all pairs of elements that sum up to zero" do
    expect(arr.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "returns indices in the order in which they appear" do
    expect(arr.two_sum.all? { |(x, y)| y >= x } ).to eq(true)
  end

  it "sorts pairs dictionary-wise" do
    sort_arr = arr.two_sum
    expect(sort_arr).to eq(sort_arr.sort)
  end

  it "returns an array of arrays" do
    expect(arr.two_sum.is_a?(Array)).to be(true)
    expect(arr.two_sum.all? { |el| el.is_a?(Array) } ).to eq(true)
  end

end

describe "Array#my_transpose" do
  let(:arr) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ] }

  it "does not call the built in Array#transpose method" do
    expect(arr).not_to receive(:transpose)
    arr.my_transpose
  end

  it "returns an array of arrays" do
    expect(arr.my_transpose.is_a?(Array)).to be(true)
    expect(arr.my_transpose.all? { |el| el.is_a?(Array) } ).to eq(true)
  end

  it "transposes the matrix on which it's called" do
    expect(arr.my_transpose).to eq(arr.transpose)
  end
end

describe "#stock_picker" do
  let(:arr) { [2, 1, 3, 4, 5] }
  let(:arr2) { [5, 4, 3, 2, 1] }

  it "returns the pair of indices where the difference of values is largest" do
    expect(stock_picker(arr)).to eq([1, 4])
  end

  it "returns an empty array if no profitable pairs are found" do
    expect(stock_picker(arr2)).to eq([])
  end
end
