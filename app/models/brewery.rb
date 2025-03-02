class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  validates :name, presence: true
  validate :year_in_range

  def year_in_range
    if year.present? && (year < 1040 || year > Time.current.year)
      errors.add(:year, "must be between 1040 and #{Time.current.year}")
    end
  end
  
  
  def ratings
    beers.includes(:ratings).flat_map(&:ratings)
  end
end
