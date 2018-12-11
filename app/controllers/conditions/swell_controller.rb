class Conditions::SwellController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:new, :create]
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

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

  def show
  end

  def edit
  end

  def update
    if @swell.update_attributes(swell_params)
      redirect_to(spot_condition_path(@condition.spot, @condition))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @swell.destroy
    redirect_to spot_path(@swell.spot)
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
      return render_404_template
    end
  end

  def set_condition
    @condition = Condition::Condition.find_by_id(params[:id])
    if @condition.blank? || @condition.spot.user != current_user
      return render_404_template
    end
  end

  def render_404_template
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
