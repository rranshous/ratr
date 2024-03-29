class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :upvote]

  def public
    upcoming_api_movies = Tmdb::Movie.upcoming
    popular_api_movies = Tmdb::Movie.popular
    now_playing_api_movies = Tmdb::Movie.now_playing
    top_rated_api_movies = Tmdb::Movie.top_rated

    upcoming_api_movies.each do |api_movie|
      create_from_api_movie(api_movie, 'upcoming')
    end

    popular_api_movies.each do |api_movie|
      create_from_api_movie(api_movie, 'popular')
    end

    now_playing_api_movies.each do |api_movie|
      create_from_api_movie(api_movie, 'now_playing')
    end

    top_rated_api_movies.each do |api_movie|
      create_from_api_movie(api_movie, 'top_rated')
    end

    @top_rated = Movie.where(category:'top_rated')
    @now_playing = Movie.where(category:'now_playing')
    @popular = Movie.where(category:'popular')
    @upcoming = Movie.where(category:'upcoming')

  end

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  def upvote
    @movie.upvotes += 1
    respond_to do |format|
      if @movie.save
        format.js
      else
        logger.error "COULD NOT SAVE MOVIE UPVOTE"
      end
    end
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :upvotes, :description)
    end

    def create_from_api_movie api_movie, category=nil
      movie = Movie.where(id:api_movie["id"]).first_or_initialize()
      movie.title = api_movie["title"]
      movie.release_date = api_movie["release_date"]
      movie.category = category
      movie.save
    end
end
