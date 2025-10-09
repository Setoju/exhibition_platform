module Admin
  class RoomsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_exhibition_center
    before_action :set_room, only: [:destroy]
    
    def index
      @rooms = apply_room_filters(@exhibition_center.rooms)
                .page(params[:page])
                .per(5)

      respond_to do |format|
        format.html
        format.json { render json: @rooms.map { |room| { id: room.id, name: room.name } } }
      end
    end

    def show
      @room = @exhibition_center.rooms.find(params[:id])
      @exhibitions = apply_exhibition_filters(@room.exhibitions)
                    .page(params[:page])
                    .per(5)
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

    def apply_room_filters(scope)
      scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
      scope = scope.where('width >= ?', params[:min_width]) if params[:min_width].present?
      scope = scope.where('height >= ?', params[:min_height]) if params[:min_height].present?
      scope = scope.where('depth >= ?', params[:min_depth]) if params[:min_depth].present?
      scope
    end

    def apply_exhibition_filters(scope)
      scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
      scope = scope.where(exhibition_type_id: params[:exhibition_type_id]) if params[:exhibition_type_id].present?
      
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
