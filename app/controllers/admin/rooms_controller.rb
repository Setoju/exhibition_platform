module Admin
  class RoomsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_exhibition_center
    before_action :set_room, only: [:destroy]

    def index
      @rooms = @exhibition_center.rooms
      respond_to do |format|
        format.html
        format.json { render json: @rooms.map { |room| { id: room.id, name: room.name } } }
      end
    end

    def show
      @room = @exhibition_center.rooms.find(params[:id])
      @exhibitions = @room.exhibitions
    end

    def new
      @room = @exhibition_center.rooms.build
    end

    def create
      @room = @exhibition_center.rooms.build(room_params)      
      if @room.save
        redirect_to admin_exhibition_center_rooms_path(@exhibition_center), notice: 'Room created successfully.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @room = @exhibition_center.rooms.find(params[:id])
    end

    def update
      @room = @exhibition_center.rooms.find(params[:id])      
      if @room.update(room_params)
        redirect_to admin_exhibition_center_path(@exhibition_center), notice: 'Room updated successfully.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @room.destroy
      redirect_to admin_exhibition_center_rooms_path(@room.exhibition_center), notice: 'Room was successfully deleted.'
    end

    private

    def set_exhibition_center
      @exhibition_center = ExhibitionCenter.find(params[:exhibition_center_id])
    end

    def room_params
      params.require(:room).permit(:name, :width, :height, :depth)
    end

    def set_room
      @room = Room.find(params[:id])
    end
  end
end
