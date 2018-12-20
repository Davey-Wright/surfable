class Conditions::WindsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot
  before_action :set_wind, only: [:destroy]

  respond_to :html, :js

  def index
    respond_with { |f| f.js { render 'index', layout: false } }
  end

  def new
    @wind = @spot.winds.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @wind = @spot.winds.create(wind_params)
    if @wind.valid?
      flash[:success] = "Successfully added Wind conditions to #{ @wind.spot.name }"
      respond_with { |f| f.js { render 'spots/show', layout: false } }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @wind.destroy
    respond_with { |f| f.js { render 'index', layout: false } }
  end

  private

    def wind_params
      params.require(:condition_wind).permit(
        :rating, :speed, name: [], direction: []
      )
    end

    def set_spot
      @spot = current_user.spots.find_by_id(params[:spot_id])
      if @spot.blank? || @spot.user != current_user
        return render_404
      end
    end

    def set_wind
      @wind = Condition::Wind.find_by_id(params[:id])
      if @wind.blank? || @wind.spot.user != current_user
        return render_404
      end
    end

    def render_404
      render file: 'public/404.html', status: :not_found, layout: false
    end

end
