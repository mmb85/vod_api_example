class LibraryController < ApplicationController
  before_action :set_library, only: [:show, :update, :destroy]

  # GET /libraries
  def index
    @content = (Movie.all + Season.all).sort_by(&:created_at)

    render json: @content
  end

  # GET /libraries/1
  def show
    render json: @library.to_json
  end

  # POST /libraries
  def create
    @library = Library.new(library_params)

    if @library.save
      render json: @library, status: :created, location: @library
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /libraries/1
  def update
    if @library.update(library_params)
      render json: @library.to_json
    else
      render json: @library.errors, status: :unprocessable_entity
    end
  end

  # DELETE /libraries/1
  def destroy
    @library.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def library_params
      params.fetch(:library, {})
    end
end
