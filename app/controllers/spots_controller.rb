class SpotsController < ApplicationController
  before_action :authenticate_user!

  def index
    @spots = current_user.spots.all
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.create(spot_params)
    if @spot.valid?
      redirect_to spot_path(@spot)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot = current_spot
    return render_404_template if @spot.blank?
  end

  def edit
    @spot = current_spot
    return render_404_template if @spot.blank?
  end

  def update
    @spot = current_spot
    return render_404_template if @spot.blank?

    @spot.update_attributes(spot_params)
    if @spot.valid?
      redirect_to spot_path(@spot)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot = current_spot
    return render_404_template if @spot.blank?
    @spot.destroy
    redirect_to user_path(current_user)
  end

  private
    def spot_params
      params.require(:spot).permit(
        :name,
        wave_break_type: [],
        wave_shape: [],
        wave_length: [],
        wave_speed: [],
        wave_direction: [],
        sessions_attributes: [
          :name,
          board_type: [],
          conditions_attributes: {
            swell_attributes: [
              :min_height,
              :max_height,
              :min_period,
              direction: []
            ],
            tide_attributes: {
              position: [
                :min,
                :max,
                basic: []
              ],
              movement: [],
              size: [
                :min,
                :max,
                basic: []
              ]
            },
            wind_attributes: [
              { direction: [] },
              :speed
            ]
          }
        ]
      )
    end

    def current_spot
      current_user.spots.find_by_id(params[:id])
    end

    def render_404_template
      render file: 'public/404.html', status: :not_found, layout: false
    end

end
