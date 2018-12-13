class Conditions::SwellsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot
  before_action :set_swell, only: [:destroy]

  respond_to :html, :js

  def index
    respond_with { |f| f.js { render 'index', layout: false } }
  end

  def new
    @swell = @spot.swell_conditions.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @swell = @spot.swell_conditions.create(swell_params)
    if @swell.valid?
      flash[:success] = "Successfully added new swell conditions to #{ @swell.spot.name }"
      redirect_to(spot_path(@swell.spot))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @swell.destroy
    respond_with { |f| f.js { render 'index', layout: false } }
  end

private

  def swell_params
    params.require(:condition_swell).permit(
      :rating,
      :min_height,
      :max_height,
      :min_period,
      direction: []
    )
  end

  def set_spot
    @spot = current_user.spots.find_by_id(params[:spot_id])
    if @spot.blank? || @spot.user != current_user
      return render_404
    end
  end

  def set_swell
    @swell = Condition::Swell.find_by_id(params[:id])
    if @swell.blank? || @swell.spot.user != current_user
      return render_404
    end
  end

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
