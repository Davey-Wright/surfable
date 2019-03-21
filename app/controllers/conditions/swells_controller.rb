module Conditions
  class SwellsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_spot
    before_action :set_swell, only: :destroy

    respond_to :html, :js

    def new
      @swell = @spot.swells.new
      respond_with { |f| f.js { render 'new', layout: false } }
    end

    def create
      @swell = @spot.swells.create(swell_params)
      if @swell.valid?
        flash[:success] = "Successfully added Swell conditions to #{@swell.spot.name}"
        respond_with { |f| f.js { render 'spots/show', layout: false } }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @swell.destroy
      flash[:success] = "Successfully deleted Swell conditions from #{@swell.spot.name}"
      respond_with { |f| f.js { render 'spots/show', layout: false } }
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
      return render_404 if @spot.blank? || @spot.user != current_user
    end

    def set_swell
      @swell = Condition::Swell.find_by_id(params[:id])
      return render_404 if @swell.blank? || @swell.spot.user != current_user
    end

    def render_404
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
