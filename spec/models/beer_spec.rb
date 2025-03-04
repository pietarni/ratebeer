require 'rails_helper'

RSpec.describe Beer, type: :model do
  before do
    @brewery = Brewery.create(name: "TestBrewery", year: 2000)
  end

  it "is valid when beer has a name, style and brewery" do
    beer = Beer.new(name: "TestBeer", style: "Lager", brewery: @brewery)
    expect(beer).to be_valid
  end

  it "is not valid without name" do
    beer = Beer.new(name: "", style: "Lager", brewery: @brewery)
    expect(beer).not_to be_valid
  end

  it "is not valid without style" do
    beer = Beer.new(name: "TestBeer", style: nil, brewery: @brewery)
    expect(beer).not_to be_valid
  end
end
