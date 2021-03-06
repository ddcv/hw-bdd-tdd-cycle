class Movie < ActiveRecord::Base

  class Movie::NoDirectorError < StandardError ; end


  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.findwithsamedirector(id)
	movie = self.find_by_id(id)
#	print movie.director
#	print movie.director.blank?
	if movie.director.blank?
		raise Movie::NoDirectorError, 'No Director'
	else
		movies = self.where(director: movie.director)
		return movies
	end
  end
end
