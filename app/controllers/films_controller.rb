class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  # GET /films
  # GET /films.json
  def index
    @films = Film.all.paginate(:page => params[:page], :per_page => 30)
  end

  def all
    @films = Film.all
  end

  def no_images

    @films = Film.where({:image_file_size => nil}).paginate(:page => params[:page], :per_page => 30)

    render :action => "index"
  end


  def search
    @films = Film.search(params[:search]).paginate(:page => (params[:page] || 1),
                                       :per_page => (params[:count] || 60))
    render :action => "index"
  end

  def year
    @year = params[:year].to_i
    @next_year = @year + 1 if @year < Time.now.year
    @previous_year = @year - 1

    @films = Film.find_by_year(params[:year])
    sort_to_most_recent_rating
  end

  def toptens
    @films = Film.joins(:screenings).favorites.all(:include => [:screenings], :order => "screenings.rating DESC")
    sort_to_most_recent_rating
    @film_years = @films.group_by { |t| t.year }
  end

  def top100
    @films = Film.top_100
  end

  def worst
    @films = Film.worst
    render :action => "top100"
  end

  def decades
    @films = Film.joins(:screenings).favorites.all(:include => [:screenings], :order => "screenings.rating DESC")
    sort_to_most_recent_rating
    @decades = @films.group_by { |t| t.decade }
  end

  def no_directors
    @films = Film.all.select {|f| f.directors.count == 0 }
    render :action => 'year'
  end

  def rating
    @start, @end = params[:rating].split("-")
    @films = Film.joins(:screenings).merge(Screening.where("rating >= #{@start} AND rating <= #{@end}")).paginate(:page => params[:page], :per_page => 30)
    render :action => "index"
  end

  # GET /films/1
  # GET /films/1.json
  def show

    @screenings = @film.screenings.order('date ASC')

    if request.path != film_path(@film)
      redirect_to @film, status: :moved_permanently
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @film }
      end
    end
  end

  # GET /films/new
  def new
    @film = Film.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films
  # POST /films.json
  def create
    @film = Film.new(film_params)
    @directors = Director.where(:id => params[:directors])
    @film.directors << @directors

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
        format.json { render action: 'show', status: :created, location: @film }
      else
        format.html { render action: 'new' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    @directors = Director.where(:id => params[:directors])
    @film.directors.destroy_all
    @film.directors << @directors

    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def film_params
      params.require(:film).permit(:title, :year, :image, :director_ids => [])
    end
  end
