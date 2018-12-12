class Conditions::WindsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot, only: [:new, :create]
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def new
    @wind = @spot.wind_conditions.new
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @wind = @spot.wind_conditions.create(wind_params)
    if @wind.valid?
      flash[:success] = "Successfully added new wind conditions to #{ @wind.spot.name }"
      redirect_to(spot_path(@wind.spot))
    else
      render :new, status: :unprocessable_entity
    end
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
