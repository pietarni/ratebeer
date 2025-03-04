FactoryBot.define do
    factory :beer do
      name { "Beer" }
      style { "Lager" }
      brewery
    end
  end
  