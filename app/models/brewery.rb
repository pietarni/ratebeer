class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy

  def ratings
    beers.includes(:ratings).flat_map(&:ratings)
  end

end