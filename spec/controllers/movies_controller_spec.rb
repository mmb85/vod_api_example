require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:valid_attributes) { { :title => 'The last Story' } }

  let(:invalid_attributes) { { :console => 'wii'} }

  describe "GET #index" do
    let!(:movie) {create :movie}

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    let!(:movie) {create :movie}

    it "returns a success response" do
      get :show, params: { id: movie.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, params: valid_attributes
        }.to change(Movie, :count).by(1)
      end

      it "renders a JSON response with the new movie" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(movie_url(Movie.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new movie" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { :title => 'The last Story was changed' } }

      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        put :update, params: {id: movie.to_param, movie: new_attributes}
        movie.reload
      end

      it "renders a JSON response with the movie" do
        movie = Movie.create! valid_attributes

        put :update, params: {id: movie.to_param, movie: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete :destroy, params: { id: movie.to_param }
      }.to change(Movie, :count).by(-1)
    end
  end

end
