class Conditions::TidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spot
  before_action :set_tide, only: [:edit, :update, :destroy]

  respond_to :html, :js

  def new
    @tide = @spot.build_tide
    respond_with { |f| f.js { render 'new', layout: false } }
  end

  def create
    @tide = @spot.create_tide(tide_params)
    if @tide.valid?
      flash[:success] = "Successfully added Tide conditions to #{ @tide.spot.name }"
      respond_with { |f| f.js { render 'spots/show', layout: false } }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_with { |f| f.js { render 'edit', layout: false } }
  end

  def update
    @tide.update_attributes(tide_params)
    if @tide.valid?
      flash[:success] = "Tide conditions were successfully updated"
      respond_with { |f| f.js { render 'spots/show', layout: false } }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tide.destroy
    flash[:success] = "Successfully deleted Swell conditions from #{ @tide.spot.name }"
    respond_with { |f| f.js { render 'spots/show', layout: false } }
  end

  private

    def tide_params
      params.require(:condition_tide).permit(
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

    def set_tide
      @tide = @spot.tide
      if @tide.blank? || @tide.spot.user != current_user
        return render_404
      end
    end

    def render_404
      render file: 'public/404.html', status: :not_found, layout: false
    end

end
