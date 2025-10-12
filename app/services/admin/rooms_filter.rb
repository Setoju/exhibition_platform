module Admin
  class RoomsFilter
    def initialize(rooms, params)
      @rooms = rooms
      @params = params
    end

    def apply_filters
      @rooms = @rooms.where("name ILIKE ?", "%#{@params[:search_name]}%") if @params[:search_name].present?
      @rooms = @rooms.where("width >= ?", @params[:min_width]) if @params[:min_width].present?
      @rooms = @rooms.where("height >= ?", @params[:min_height]) if @params[:min_height].present?
      @rooms = @rooms.where("depth >= ?", @params[:min_depth]) if @params[:min_depth].present?

      @rooms
    end
  end
end
