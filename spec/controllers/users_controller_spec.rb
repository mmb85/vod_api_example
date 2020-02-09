require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { { :email => 'fake@email.com' } }

  let(:invalid_attributes) { { :name => 'Frodo'} }

  describe "GET #index" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :show, params: {id: user.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { :email => 'updated@email.com'} }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes

        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

  describe "GET #purchases" do
    before do
      @user = User.create(email: 'new_custom@email.com')
      movie = Movie.create(title: 'My scary movie')
      @purchase = Purchase.create(user_id: @user.id, quality: 'HD', season_id: nil, movie_id: movie.id, price: 2.99)
    end

    it "GET Purchases for an user" do
      get :purchases, params: { use_route: '/users/#{@user.id}/purchases', id: @user.id }

      expect(response.body).to include("[{\"id\":1,\"movie_id\":1,\"season_id\":null,\"user_id\":1,\"price\":2.99,\"quality\":\"HD\"")
      expect(@user.purchases.include?(@purchase)).to be_truthy
    end
  end
end
