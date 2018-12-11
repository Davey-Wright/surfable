class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:new, :create]
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def new
    @condition = @spot.conditions.new
    @condition.build_swell
    @condition.build_tide
    @condition.winds.build
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @condition = @spot.conditions.create(condition_params)
    if @condition.valid?
      redirect_to(spot_path(@condition.spot))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @condition.update_attributes(condition_params)
      redirect_to(spot_condition_path(@condition.spot, @condition))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @condition.destroy
    redirect_to spot_path(@condition.spot)
  end

private

  def condition_params
    params.require(:condition_condition).permit(
      :name,
      :board_selection,
      swell_attributes: [
        :min_height,
        :max_height,
        :min_period,
        direction: []
      ],
      tide_attributes: [
        position_high_low: [],
        position_low_high: [],
        size: []
      ],
      winds_attributes: [
        name: [],
        direction: [],
        speed: []
      ]
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
