class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	# if the session doesn't exist, create it
	if ( session[:all_ratings].nil? )
	  session[:all_ratings] = {'G'=>true, 'PG'=>true, 'PG-13'=>true, 'R'=>true, 'NC-17'=>true}
	end

	# update session from form data
    if (!params[:ratings].nil?)
		session[:all_ratings].each do |r|
		  session[:all_ratings][r[0]] = params[:ratings].has_key?(r[0])
	  end
	end
	@all_ratings = session[:all_ratings]

	# get and post the results
    @movies = Movie.order(sort_column + " " + sort_direction).where(:rating => ratings_select)
  end
  
  def sort_column
	#Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
	if ( session[:sort].nil? )
	  session[:sort] = "title"
	end
	if ( Movie.column_names.include?(params[:sort]) )
	  session[:sort] = params[:sort]
	end
	return session[:sort]
  end

  def sort_direction
	#%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	if ( %w[asc desc].include?(params[:direction]) )
	  session[:direction] = params[:direction]
	end
	if ( session[:direction].nil? )
	  session[:direction] = "asc"
	end
	return session[:direction]
  end

  def ratings_select
	
	if (session[:ratings].nil?) 
	  	params[:ratings] = {'G'=>true, 'PG'=>true, 'PG-13'=>true, 'R'=>true, 'NC-17'=>true}
	end
    if (!params[:ratings].nil?)
	  session[:ratings] = params[:ratings].keys
	end
	return session[:ratings]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
