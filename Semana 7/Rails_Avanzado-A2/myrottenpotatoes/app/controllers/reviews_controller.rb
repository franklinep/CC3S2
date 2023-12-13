class ReviewsController < ApplicationController
    before_filter :has_moviegoer_and_movie, only: [:new, :create, :edit, :update]
    protected
    def has_moviegoer_and_movie
        unless @current_user
            flash[:warning] = 'You must be logged in to create a review.'
            redirect_to login_path
        end
        unless (@movie = Movie.where(:id => params[:movie_id]))
            flash[:warning] = 'Review must be for an existing movie.'
            redirect_to movies_path
        end
    end

    public
    def new
        @review = @movie.reviews.build
    end

    def create
    # since moviegoer_id is a protected attribute that won't get
    # assigned by the mass-assignment from params[:review], we set it
    # by using the << method on the association. We could also
    # set it manually with review.moviegoer = @current_user.
    @current_user.reviews << @movie.reviews.build(params[:review])
    redirect_to movie_path(@movie)
    end

    def edit
        @review = @movie.reviews.find(params[:id])
        unless @current_user == @review.moviegoer
            flash[:warning] = "No estas autorizado para editar cambios en esta reseña."
            redirect_to movie_path(@movie)
            return
        end
    end

    def update
        @review = @movie.reviews.find(params[:id])
        p @review.moviegoer
        unless @current_user == @review.moviegoer
            flash[:warning] = "No estas autorizado para actualizar esta reseña."
            redirect_to movie_path(@movie)
            return
        end

        if @review.update_attributes(params[:review])
            flash[:notice] = 'La reseña fue exitosamente actualizada.'
            redirect_to movie_path(@movie)
        else
            render :action => 'edit'    
        end
    end
end