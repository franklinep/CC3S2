# spec/fake_movie_spec.rb
require 'rails_helper.rb'

RSpec.describe Movie do
    describe "#name_with_rating" do
      it "returns the formatted name with rating" do
        fake_movie = double('Movie')

        allow(fake_movie).to receive(:title).and_return('Casablanca')
        allow(fake_movie).to receive(:rating).and_return('PG')
        
        expect(fake_movie.name_with_rating).to eq 'Casablanca (PG)'
      end
    end
  end