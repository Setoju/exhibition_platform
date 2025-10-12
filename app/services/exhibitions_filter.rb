class ExhibitionsFilter
  def initialize(exhibitions, params)
    @exhibitions = exhibitions
    @params = params
  end

  def apply_filters
    @exhibitions = @exhibitions.where("name ILIKE ?", "%#{@params[:search_name]}%") if @params[:search_name].present?
    @exhibitions = @exhibitions.where(exhibition_type_id: @params[:exhibition_type_id]) if @params[:exhibition_type_id].present?
    @exhibitions = @exhibitions.joins(:exhibition_center).where("exhibition_centers.name ILIKE ?", "%#{@params[:exhibition_center_name]}%") if @params[:exhibition_center_name].present?
    @exhibitions = @exhibitions.joins(:room).where("rooms.name ILIKE ?", "%#{@params[:room_name]}%") if @params[:room_name].present?

    if @params[:status].present?
      case @params[:status]
      when "Upcoming"
        @exhibitions = @exhibitions.where("start_date > ?", Date.today)
      when "Ongoing"
        @exhibitions = @exhibitions.where("start_date <= ? AND end_date >= ?", Date.today, Date.today)
      when "Finished"
        @exhibitions = @exhibitions.where("end_date < ?", Date.today)
      end
    end

    @exhibitions
  end
end
