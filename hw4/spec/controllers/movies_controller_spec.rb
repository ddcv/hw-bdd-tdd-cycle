require 'spec_helper'
require 'rails_helper'
#require 'rspec'
 
describe MoviesController do
  fixtures :movies
  describe 'Finding Movies with Same Director' do
    before :each do
      @RSmovie = movies(:documentary_movie)
      @otherRSmovie = movies(:alien_movie)
      @nilmovie = movies(:milk_movie)
    end
    it 'should call the model method that performs finding with same director' do
      Movie.should_receive(:findwithsamedirector).with(@RSmovie.id.to_s)
      get :findwithsamedirector, :id => @RSmovie.id
    end
    describe 'on valid search' do
        it 'should select the Similar Movies template for rendering' do
      	    Movie.should_receive(:findwithsamedirector).with(@RSmovie.id.to_s)
            get "findwithsamedirector", id: "#{@RSmovie.id}"
            response.should render_template('findwithsamedirector')
        end
        it 'should make the Same Director Search Results available to that template' do
      	    Movie.should_receive(:findwithsamedirector).with(@RSmovie.id.to_s).and_return([@RSmovie, @otherRSmovie])
            get :findwithsamedirector,  id: "#{@RSmovie.id}"

        end
     end
    describe 'on invalid search' do
        it 'should select the All Movies template for rendering' do
      	    Movie.should_receive(:findwithsamedirector).with(@nilmovie.id.to_s)
            get 'findwithsamedirector',  id: "#{@nilmovie.id}"
            response.should render_template('/')
	end
    end
  end
end
