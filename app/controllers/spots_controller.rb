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
    if @spot.blank?
      return render file: 'public/404.html', status: :not_found, layout: false
    end
    require_authorized_for_current_spot
  end

  def edit
    @spot = current_spot
    if @spot.blank?
      return render file: 'public/404.html', status: :not_found, layout: false
    end
    require_authorized_for_current_spot
  end

  def update
    @spot = current_spot
    if @spot.blank?
      return render file: 'public/404.html', status: :not_found, layout: false
    end
    require_authorized_for_current_spot

    @spot.update_attributes(spot_params)
    if @spot.valid?
      redirect_to spot_path(@spot)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def spot_params
    params.require(:spot).permit(:name,
      { wave_break_type: [] },
      { wave_shape: [] },
      { wave_length: [] },
      { wave_speed: [] },
      { wave_direction: [] })
  end

  def current_spot
    current_user.spots.find_by_id(params[:id])
  end

  def require_authorized_for_current_spot
		if current_user != current_spot.user
			return render file: 'public/404.html', status: :forbidden, layout: false
		end
	end

end
