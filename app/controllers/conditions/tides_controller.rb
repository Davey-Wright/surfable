class Conditions::TidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:new, :create]
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def new
    @tide = @spot.tide_conditions.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @tide = @spot.tide_conditions.create(tide_params)
    if @tide.valid?
      flash[:success] = "Successfully added new tide conditions to #{ @tide.spot.name }"
      redirect_to(spot_path(@tide.spot))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    # if @swell.update_attributes(swell_params)
    #   redirect_to(spot_condition_path(@condition.spot, @condition))
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    # @swell.destroy
    # redirect_to spot_path(@swell.spot)
  end

private

  def tide_params
    params.require(:condition_tide).permit(
      :rating,
      rising: [],
      dropping: [],
      size: []
    )
  end

  def set_spot
    @spot = current_user.spots.find_by_id(params[:spot_id])
    if @spot.blank? || @spot.user != current_user
      return render_404
    end
  end

  def set_condition
    @condition = Condition::Condition.find_by_id(params[:id])
    if @condition.blank? || @condition.spot.user != current_user
      return render_404
    end
  end

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end

end
