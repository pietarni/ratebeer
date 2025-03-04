class User < ApplicationRecord
  include RatingAverage
  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*[A-Z])(?=.*\d)/, message: "must include at least one uppercase letter and one number" }

  def favorite_style
    return nil if ratings.empty?

    ratings
      .group_by { |r| r.beer.style }
      .map { |style, ratings_array| [style, ratings_array.sum(&:score).to_f / ratings_array.size] }
      .max_by { |_style, avg| avg }
      &.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.group_by { |r| r.beer.brewery }
           .map { |brewery, ratings| [brewery, ratings.sum(&:score).to_f / ratings.size] }
           .max_by { |_brewery, avg| avg }
           &.first
  end
end

class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user # rating kuuluu myös käyttäjään

  def to_s
    "#{beer.name} #{score}"
  end
end
