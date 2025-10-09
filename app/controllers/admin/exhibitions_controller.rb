module Admin
  class ExhibitionsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_room
    before_action :set_exhibition, only: [:destroy]

    def index
      @exhibitions = apply_filters(Exhibition.all)
                    .page(params[:page])
                    .per(9)
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
        render :new, status: :unprocessable_entity
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
        render :edit, status: :unprocessable_entity
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
      params.require(:exhibition).permit(
        :name, :description, :start_date, :end_date, :exhibition_type_id, :exhibition_center_id, :room_id
      )
    end

    def apply_filters(scope)
      scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
      scope = scope.where(exhibition_type_id: params[:exhibition_type_id]) if params[:exhibition_type_id].present?
      scope = scope.joins(:exhibition_center).where('exhibition_centers.name ILIKE ?', "%#{params[:exhibition_center_name]}%") if params[:exhibition_center_name].present?
      scope = scope.joins(:room).where('rooms.name ILIKE ?', "%#{params[:room_name]}%") if params[:room_name].present?
      
      if params[:status].present?
        case params[:status]
        when 'Upcoming'
          scope = scope.where('start_date > ?', Date.today)
        when 'Ongoing'
          scope = scope.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
        when 'Finished'
          scope = scope.where('end_date < ?', Date.today)
        end
      end
      
      scope
    end
  end
end
