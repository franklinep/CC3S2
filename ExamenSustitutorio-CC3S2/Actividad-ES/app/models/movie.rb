class Movie < ActiveRecord::Base
  #validates :title, presence: true  
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  # implement this method. Remeber to exclude [self]
  # (the current movie) from your return value
  def others_by_same_director(director)
    Movie.where(director: director).where.not(id: id)
  end
  
  def name_with_rating
    return "#{title} (#{rating})"
  end
  
end
