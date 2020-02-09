require 'rails_helper'

RSpec.describe SeasonsController, type: :controller do
  let(:valid_attributes) { { title: 'How I meet your mother', plot: 'Great sitcom', number: 1 }  }

  let(:invalid_attributes) { {console: 'neo-geo'} }

  describe "GET #index" do
    it "returns a success response" do
      season = Season.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      season = Season.create! valid_attributes
      get :show, params: {id: season.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Season" do
        expect {
          post :create, params: valid_attributes
        }.to change(Season, :count).by(1)
      end

      it "renders a JSON response with the new season" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(season_url(Season.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new season" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { title: 'How I KILL your mother', plot: 'Great GORE sitcom', number: 1 }  }

      it "updates the requested season" do
        season = Season.create! valid_attributes
        put :update, params: {id: season.to_param, season: new_attributes}
        season.reload
      end

      it "renders a JSON response with the season" do
        season = Season.create! valid_attributes

        put :update, params: {id: season.to_param, season: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested season" do
      season = Season.create! valid_attributes
      expect {
        delete :destroy, params: {id: season.to_param}
      }.to change(Season, :count).by(-1)
    end
  end

end
