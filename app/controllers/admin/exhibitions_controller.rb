module Admin
  class ExhibitionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
    before_action :set_room
    before_action :set_exhibition, only: [:destroy]

    def index
      @exhibitions = Exhibition.all
    end

    def show
      @room = Room.find(params[:room_id])
      @exhibition = @room.exhibitions.find(params[:id])
    end

    def new
      @room = Room.find(params[:room_id])
      @exhibition = @room.exhibitions.build
    end

    def create
      @room = Room.find(params[:room_id])
      @exhibition = @room.exhibitions.build(exhibition_params)
      if @exhibition.save
        redirect_to admin_exhibition_center_room_path(@room.exhibition_center, @room), notice: 'Exhibition created successfully.'
      else
        render :new, alert: 'Failed to create Exhibition.'
      end
    end

    def edit
      @exhibition = Exhibition.find(params[:id])
    end

    def update
      @exhibition = Exhibition.find(params[:id])
      if @exhibition.update(exhibition_params)
        redirect_to admin_exhibitions_path, notice: 'Exhibition updated successfully.'
      else
        render :edit
      end
    end

    def destroy
      @exhibition.destroy
      redirect_to exhibitions_path, notice: 'Exhibition was successfully deleted.'
    end

    private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def set_exhibition
      @exhibition = Exhibition.find(params[:id])
    end

    def exhibition_params
      params.require(:exhibition).permit(:name, :description, :start_date, :end_date, :exhibition_type_id, :exhibition_center_id, :room_id)
    end

    def authorize_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
    end
  end
end
