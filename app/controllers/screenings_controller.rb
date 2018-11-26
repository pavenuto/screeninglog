class ScreeningsController < ApplicationController
  before_action :set_screening, only: [:show, :edit, :update, :destroy]

  # GET /screenings
  # GET /screenings.json
  def index
    @screenings = Screening.all.includes(:film).order(date: :asc).paginate(:page => params[:page], :per_page => 30)
  end

  def recent
    @screenings = Screening.all.includes(film: [:directors]).order(date: :desc).paginate(:page => (params[:page] || 1),
                                                            :per_page => (params[:count] || 60))
  end

  def year
    @screenings = Screening.all.includes(:film).order(date: :asc).where("date LIKE ?", params[:year] + "%")
    @year = params[:year].to_i
    @next_year = @year + 1 if @year < Time.now.year
    @previous_year = @year - 1
  end

  def visualized
    @screenings = Screening.all

    @one = @screenings.where("rating >= 1 AND rating <= 10").count()
    @two = @screenings.where("rating >= 11 AND rating <= 20").count()
    @three = @screenings.where("rating >= 21 AND rating <= 30").count()
    @four = @screenings.where("rating >= 31 AND rating <= 40").count()
    @five = @screenings.where("rating >= 41 AND rating <= 50").count()
    @six = @screenings.where("rating >= 51 AND rating <= 60").count()
    @seven = @screenings.where("rating >= 61 AND rating <= 70").count()
    @eight = @screenings.where("rating >= 71 AND rating <= 80").count()
    @nine = @screenings.where("rating >= 81 AND rating <= 90").count()
    @ten = @screenings.where("rating >= 91 AND rating <= 100").count()

    @ratings = [ @one, @two, @three, @four, @five, @six, @seven, @eight, @nine, @ten]

    @films = Film.all
    @decades = @films.group_by { |t| t.decade }

    @directors = Director.joins(:films).select("directors.*, count(films.id) as fcount").group("directors.id").order("fcount DESC").limit(30)
    @most_watched_films = Film.joins(:screenings).select("films.*, count(screenings.id) as scount").group("films.id").order("scount DESC").limit(15)
  end

  # GET /screenings/1
  # GET /screenings/1.json
  def show
  end

  # GET /screenings/new
  def new
    @screening = Screening.new
  end

  # GET /screenings/1/edit
  def edit
  end

  # POST /screenings
  # POST /screenings.json
  def create
    @screening = Screening.new(screening_params)

    respond_to do |format|
      if @screening.save
        format.html { redirect_to @screening, notice: 'Screening was successfully created.' }
        format.json { render action: 'show', status: :created, location: @screening }
      else
        format.html { render action: 'new' }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screenings/1
  # PATCH/PUT /screenings/1.json
  def update
    respond_to do |format|
      if @screening.update(screening_params)
        format.html { redirect_to @screening, notice: 'Screening was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screenings/1
  # DELETE /screenings/1.json
  def destroy
    @screening.destroy
    respond_to do |format|
      format.html { redirect_to screenings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screening
      @screening = Screening.find(params[:id], :include => [:film])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screening_params
      params.require(:screening).permit(:date, :rating, :film_id)
    end
end
