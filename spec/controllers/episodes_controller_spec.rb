require 'rails_helper'

RSpec.describe EpisodesController, type: :controller do
  let!(:season) { create :season }
  let(:valid_attributes) { { title: 'Episode Juan', plot: '4th may', season_id: season.id, number: 1 } }

  let(:invalid_attributes) { { console: 'ps4'} }

  describe "GET #index" do
    let!(:episode) {create :episode}

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      episode = Episode.create! valid_attributes
      get :show, params: {id: episode.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Episode" do
        expect {
          post :create, params: valid_attributes
        }.to change(Episode, :count).by(1)
      end

      it "renders a JSON response with the new episode" do

        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(episode_url(Episode.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new episode" do

        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { title: 'Episode Tu', plot: '5th may', season_id: season.id, number: 2 } }

      it "updates the requested episode" do
        episode = Episode.create! valid_attributes
        put :update, params: {id: episode.to_param, episode: new_attributes}
        episode.reload
      end

      it "renders a JSON response with the episode" do
        episode = Episode.create! valid_attributes

        put :update, params: {id: episode.to_param, episode: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested episode" do
      episode = Episode.create! valid_attributes
      expect {
        delete :destroy, params: {id: episode.to_param}
      }.to change(Episode, :count).by(-1)
    end
  end

end
