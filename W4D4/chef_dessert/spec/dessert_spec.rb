require 'rspec'
require 'dessert'
require 'chef'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert){Dessert.new("browni", 30, chef)}
  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("browni")
    end

    it "sets a quantity" do 
      expect(dessert.quantity).to eq(30)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("browni","30", chef)}.to raise_error(ArgumentError)
      end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(dessert.ingredients).to_not include('tulsi')
      dessert.add_ingredient('tulsi')
      expect(dessert.ingredients).to include('tulsi')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect(dessert.mix!).to eq(dessert.ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(10)
      expect(dessert.quantity).to eq(20)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(40)}.to raise_error(RuntimeError)
    end
  end
  let(:chef_1){Chef.new("alvin")}
  subject(:dessert_1){Dessert.new("browni", 30, chef_1)}
  describe "#serve" do
    it "contains the titleized version of the chef's name" do 
      expect(dessert_1.serve).to eq("Chef alvin the Great Baker has made 30 brownis!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      dessert_1.make_more
      expect(dessert_1.temp).to eq(400)
    end
  end
end
