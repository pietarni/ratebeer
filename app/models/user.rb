class User < ApplicationRecord
  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*[A-Z])(?=.*\d)/, message: "must include at least one uppercase letter and one number" }
end

class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user # rating kuuluu myös käyttäjään

  def to_s
    "#{beer.name} #{score}"
  end
end
