class LibraryController < ApplicationController
  before_action :set_library, only: [:show, :update, :destroy]

  # GET /libraries
  def movies
    @content = Movie.all.order(created_at: :desc)

    render json: @content
  end

  # An endpoint to return the seasons ordered by creation, including the list of episodes ordered by its number.
  def seasons_info
    @content = []
    seasons = Season.all.order(created_at: :desc)
    seasons.each do |season|
      debugger
      @content << [season]
      season.episodes.order(number: :asc).each do |episode|
        @content[-1] << episode
      end
    end

    render json: @content
  end

  # GET /libraries/1
  def show
    render json: @library
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
      render json: @library
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
