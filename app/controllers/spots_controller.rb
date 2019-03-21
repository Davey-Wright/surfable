class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: %i[show edit update destroy]
  respond_to :html, :js

  def index
    @spots = current_user.spots.all
    @spots_map = @spots.map do |s|
      spot = s.attributes
      spot['path'] = spot_path(s)
      spot
    end
  end

  def new
    @spot = Spot.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @spot = current_user.spots.create(spot_params)
    if @spot.valid?
      flash[:success] = "#{@spot.name} was successfully added to your spots"
      respond_with { |f| f.js { render 'show', layout: false } }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot.decorate
  end

  def edit
    respond_with { |f| f.js { render 'edit', layout: false } }
  end

  def update
    @spot.update_attributes(spot_params)
    if @spot.valid?
      flash[:success] = "#{@spot.name} was successfully updated"
      respond_with { |f| f.js { render 'show', layout: false } }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_path
  end

  private

  def spot_params
    params.require(:spot).permit(
      :name,
      :latitude,
      :longitude,
      wave_break_type: [],
      wave_shape: [],
      wave_length: [],
      wave_speed: [],
      wave_direction: []
    )
  end

  def set_spot
    @spot = current_user.spots.find_by_id(params[:id])
    return render_404 if @spot.blank? || @spot.user != current_user
  end

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
