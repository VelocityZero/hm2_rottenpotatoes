class Movie < ActiveRecord::Base
  @active_ratings = {"G" => 1, "PG" => 1, "PG-13" => 1, "R" => 1} 
  def getRatings
	return @active_ratings
  end
end
