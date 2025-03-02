module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    avg = ratings.map(&:score).sum / ratings.count.to_f
    avg.round(2)
  end
end
