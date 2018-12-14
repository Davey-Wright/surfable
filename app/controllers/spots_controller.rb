class SpotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @spots = current_user.spots.all
  end

  def new
    @spot = Spot.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @spot = current_user.spots.create(spot_params)
    if @spot.valid?
      flash[:notice] = 'shaka melaka ting ling'
      redirect_to spot_path(@spot)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    respond_with { |f| f.js { render 'edit', layout: false } }
  end

  def update
    @spot.update_attributes(spot_params)
    if @spot.valid?
      redirect_to spot_path(@spot)
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
        wave_break_type: [],
        wave_shape: [],
        wave_length: [],
        wave_speed: [],
        wave_direction: []
      )
    end

    def set_spot
      @spot = current_user.spots.find_by_id(params[:id])
      if @spot.blank? || @spot.user != current_user
        return render_404
      end
    end

    def render_404
      render file: 'public/404.html', status: :not_found, layout: false
    end

end
