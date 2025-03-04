FactoryBot.define do
    factory :rating do
      score { 10 }
      beer
      user
    end
  end
  