# in spec/models/movie_spec.rb
describe Movie do
  fixtures :movies
  describe 'movie has a director' do
      it 'should find movies by the same director' do
           movie = movies(:documentary_movie)
           value = Movie.findwithsamedirector(movie.id)
           value.each do |mov|
	       mov.director.should == 'Ridley Scott'
	       mov.director.should_not == 'George Lucas'
           end
       end
  end
  describe 'movie has no director' do
      it 'should raise error' do
           movie = movies(:milk_movie)
           lambda {Movie.findwithsamedirector(movie.id)}.should raise_error(Movie::NoDirectorError, 'No Director')
      end
  end
end
