class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  validates :user_id, uniqueness: { scope: :beer_club_id }
end
