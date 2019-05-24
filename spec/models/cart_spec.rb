require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }
  describe "#total_count" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        1 => 2,  # two copies of item 1
        2 => 3   # three copies of item 2
      })
      expect(cart.total_count).to eq(5)
    end
  end

  describe "#count_of" do
    it "returns the count of all items in the cart" do
      cart = Cart.new({})

      expect(cart.count_of(5)).to eq(0)
    end
  end

  describe "#add_item" do
    it "adds an item that hasn't been added yet" do

      subject.add_item('3')

      expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
    end
  end

  describe "#item_ids" do
    it "returns an array of item ids" do
      expect(subject.item_ids).to eq(["1", "2"])
    end
  end
end
