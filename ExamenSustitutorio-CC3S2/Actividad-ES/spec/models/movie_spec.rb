# spec/models/movie_spec.rb:

require 'rails_helper.rb'


describe Movie do
    fixtures :movies
    it 'includes rating and year in full name' do
        movie = movies(:milk_movie)
        expect(movie.name_with_rating).to eq('Milk (R)')
    end
end