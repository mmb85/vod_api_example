class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :purchases]

  # GET /users
  def index
    @users = User.all

    render json: @users.to_json
  end

  # GET /users/1
  def show
    render json: @user.to_json
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.to_json, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user.to_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # GET /users/1/purchases
  def purchases
    purchases = @user.purchases.where(expired: false).order('created_at DESC')
    json =  Rails.cache.fetch(User.cache_key(purchases)) do
      purchases.to_json
    end

    render json: purchases.to_json
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:email)
  end
end
