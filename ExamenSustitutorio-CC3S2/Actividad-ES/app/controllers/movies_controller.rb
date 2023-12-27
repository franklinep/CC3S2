class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    
    #setCookie('miCookie', 10, 1)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    @movie.director = params[:director]

    TraceLocation.trace(match: /activerecord/) { @movie.validate }

    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to redirect_to movies_path
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end
  def update
    @movie = Movie.find(params[:id])
    @movie.director = params[:director] # Agrega esta línea para asignar el director
  
    TraceLocation.trace(match: /activerecord/) { @movie.validate }

    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  # Note - for Part 1, you may need to modify this method.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
