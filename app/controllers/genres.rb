MovieDb::App.controllers :genres do
  get :index do
    @genres = Genre.all
    render 'index'
  end
  
  get :index, :with => :id do
    @genre = Genre.find(params[:id])
    @name = @genre.name
    @movies = @genre.movies
    render 'genre'
  end

  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
