require 'rails_helper'

RSpec.describe User, type: :model do
  it "does not save user, if password is too short or consists only of lower case letters" do
    user = User.create(username: "TestUser", password: "aaa", password_confirmation: "aaa")
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "#favorite_style" do
    let(:user) { FactoryBot.create(:user) }

    it "returns nil if the user has no ratings" do
      expect(user.favorite_style).to be_nil
    end

    it "returns the style with the highest average rating when multiple ratings exist" do
      beer1 = FactoryBot.create(:beer, style: "IPA")
      beer2 = FactoryBot.create(:beer, style: "Lager")
      
      FactoryBot.create(:rating, score: 10, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 5, beer: beer2, user: user)
      
      expect(user.favorite_style).to eq("IPA")
    end
  end


  describe "#favorite_brewery" do
    let(:user) { FactoryBot.create(:user) }
    it "return nil if user has made no ratings" do
      expect(user.favorite_brewery).to be_nil
    end
  
    it "when there are many ratings, return brewery with highest rating average" do
      brewery1 = FactoryBot.create(:brewery, name: "Brewery1")
      brewery2 = FactoryBot.create(:brewery, name: "Brewery2")
      beer1 = FactoryBot.create(:beer, brewery: brewery1)
      beer2 = FactoryBot.create(:beer, brewery: brewery2)
      FactoryBot.create(:rating, score: 33, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 66, beer: beer2, user: user)
      expect(user.favorite_brewery).to eq(brewery2)
    end
  end
end