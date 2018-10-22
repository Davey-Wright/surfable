class SessionsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_spot, only: [:new, :create]
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def new
    @session = Session.new
  end

  def create
    @session = @spot.sessions.create(session_params)
    if @session.valid?
      redirect_to(spot_session_path(@session.spot, @session))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @session.update_attributes(session_params)
      redirect_to(spot_session_path(@session.spot, @session))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @session.destroy
    redirect_to spot_path(@session.spot)
  end

private

  def session_params
    params.require(:session).permit(
      :name,
      board_type: [],
      conditions_attributes: {
        swell_attributes: [
          :min_height,
          :max_height,
          :min_period,
          direction: []
        ],
        tide_attributes: [
          position_min: 5,
          position_max: 10,
          size: []
        ],
        wind_attributes: [
          { direction: [] },
          :speed
        ]
      }
    )
  end

  def set_spot
    @spot = current_user.spots.find_by_id(params[:spot_id])
    if @spot.blank? || @spot.user != current_user
      return render_404_template
    end
  end

  def set_session
    @session = Session.find_by_id(params[:id])
    if @session.blank? || @session.spot.user != current_user
      return render_404_template
    end
  end

  def render_404_template
    render file: 'public/404.html', status: :not_found, layout: false
  end

end
