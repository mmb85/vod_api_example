require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  let!(:user) { create :user }
  let!(:movie) { create :movie }
  let!(:season) { create :season }
  let(:valid_attributes) { { user_id: user.id, quality: 'HD', season_id: nil, movie_id: movie.id, price: 2.99 } }

  let(:invalid_attributes) { { console: 'xbox one' } }

  describe "GET #index" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      purchase = Purchase.create! valid_attributes
      get :show, params: {id: purchase.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Purchase" do
        expect {
          post :create, params: valid_attributes
        }.to change(Purchase, :count).by(1)
      end

      it "renders a JSON response with the new purchase" do

        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(purchase_url(Purchase.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new purchase" do

        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "Purchase option must be unique" do
      let(:movie2) { create :movie, {title: 'new title' } }
      let(:user2) { create :user, { email: 'user2@email.com' } }
      let(:season2) { create :season, { title: 'new season title' } }
      let!(:both_attributes) { { user_id: user2.id, quality: 'HD', season_id: season2.id, movie_id: movie2.id, price: 2.99 } }

      it "Purchase should include only season or movie" do
        post :create, params: both_attributes
        expect(response.body).to eq('{"movie_id":["season_id is present too"],"season_id":["movie_id is present too"]}')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { user_id: user.id, quality: 'HD', season_id: nil, movie_id: movie.id, price: 4.99 } }

      it "updates the requested purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, params: {id: purchase.to_param, purchase: new_attributes}
        purchase.reload
      end

      it "renders a JSON response with the purchase" do
        purchase = Purchase.create! valid_attributes

        put :update, params: {id: purchase.to_param, purchase: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested purchase" do
      purchase = Purchase.create! valid_attributes
      expect {
        delete :destroy, params: {id: purchase.to_param}
      }.to change(Purchase, :count).by(-1)
    end
  end

end
