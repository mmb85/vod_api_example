class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :purchases]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
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

    render json: purchases
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {})
    end

    # TODO Not used yet, maybe good idea to add to purchase as a string column
    def remaining_time(purchase_id)
      purchase = Purchase.find purchase_id
      total_seconds = ((purchase.created_at + 3.days - Time.now)).to_i
      hours = (total_seconds/ 3600).to_i
      minutes = ((total_seconds % 3600) / 60).to_i
      seconds = ((total_seconds % 3600) % 60).to_i
      puts "#{"%.2d" % hours}:#{"%.2d" % minutes}:#{"%.2d" % seconds}"
    end
end
