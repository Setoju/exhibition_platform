class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path, notice: 'Room created successfully.'
    else
      render :new, alert: 'Failed to create Room.'
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :width, :height, :depth, :exhibition_center_id)
  end
end
