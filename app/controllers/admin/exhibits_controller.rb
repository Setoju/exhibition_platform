module Admin
  class ExhibitsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_exhibit, only: [:destroy]
    before_action :set_exhibition, only: [:new, :create]

    def new
      @exhibit = @exhibition.exhibits.build
    end

    def create
      @exhibit = @exhibition.exhibits.build(exhibit_params)      
      if @exhibit.save
        redirect_to admin_exhibition_center_path(@exhibition.room.exhibition_center), notice: 'Exhibit created successfully.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      exhibition = @exhibit.exhibition
      @exhibit.destroy
      redirect_to exhibition_path(exhibition), notice: 'Exhibit was successfully deleted.'
    end

    private

    def set_exhibit
      @exhibit = Exhibit.find(params[:id])
    end

    def set_exhibition
      @exhibition = Exhibition.find(params[:exhibition_id])
    end    def exhibit_params
      params.require(:exhibit).permit(:name, :width, :height, :depth, :weight, :creation_date, :room_id, :material, :copy)
    end
  end
end
