require "rails_helper"
require 'spec_helper'

describe MoviesController, type: :controller do
  before do
    @movie = Movie.create(:title => "mov1", 
                      :rating => "PG", 
                      :description => "sample", 
                      :release_date => "1977-05-25", 
                      :director => "me")
    
    @m2 = Movie.create(:id => "205", title: "Movie2", director: "sam")
    @m3 = Movie.create(:id => "206", title: "Movie3", director: "sam")

  end
  
  describe "find a movie" do
    it "should show movie details" do
      Movie.should_receive(:find).with('1').and_return(@movie)
      get :show, {:id => '1'}
      response.should render_template('show')
    end
  end
  
  describe "ensure all ratings are valid" do
    it 'returns correct movie ratings' do
      expect(Movie.all_ratings).to eq %w[G PG PG-13 NC-17 R]
    end
  end
  
  describe 'movie has a director' do
    it 'responds to the directed_by route' do
      get :directed_by, {:director => @movie.director}
    end
  end 

  describe 'search similar movies' do
    it 'assigns similar movies to the template' do
      get :directed_by, {:director => @m2.director}
      expect(Movie.where(:director => @m2.director).size).to eq(2)
    end
  end

  describe "check create" do
    let(:params) {{:title => "Star Wars"}}
    let(:movie) {double('movie', params)}

    it 'use create to create a new movie' do
      expect(Movie).to receive(:create!).with(params).and_return(movie)
      post :create, {movie: params}  
    end
  end

  describe "ensure destroy works" do
    let(:movie) {double('movie',:title => 'Star Wars')}
    let(:id) {'2'}

    it 'use find to retrieve a movie' do
      expect(Movie).to receive(:find).with(id).and_return(movie)
      allow(movie).to receive(:destroy)
      delete :destroy, {:id => id}
    end
  end
end