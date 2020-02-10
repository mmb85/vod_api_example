class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :update, :destroy]

  EXPIRATION_DATE = Time.now - 3.days

  # GET /purchases
  def index
    purchases = Purchase.all
    json =  Rails.cache.fetch(Purchase.cache_key(purchases)) do
      purchases.to_json
    end

    render json: json
  #  @purchases = Purchase.all
  #  @purchases.where("created_at  < ?", EXPIRATION_DATE).update_all(expired: true)

  #  render json: @purchases
  end

  # GET /purchases/1
  def show
    @purchase.update_attribute(expired: true) if @purchase.created_at < EXPIRATION_DATE
    render json: @purchase.to_json
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      render json: @purchase.to_json, status: :created, location: @purchase
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(purchase_params)
      @purchase.update_attribute(expired: true) if @purchase.created_at < EXPIRATION_DATE
      render json: @purchase.to_json
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # DELETE /purchases/1
  def destroy
    @purchase.destroy
  end

  def purchase
    create
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def purchase_params
    params.permit(:user_id, :quality, :season_id, :movie_id, :price)
  end
end
