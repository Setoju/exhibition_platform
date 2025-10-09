class ExhibitionsController < ApplicationController
  def index
    @exhibitions = apply_filters(Exhibition.all)
                  .page(params[:page])
                  .per(9)
  end

  def show
    @exhibition = Exhibition.find(params[:id])
  end

  private

  def apply_filters(scope)
    scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
    scope = scope.where(exhibition_type_id: params[:exhibition_type_id]) if params[:exhibition_type_id].present?
    scope = scope.joins(:exhibition_center).where('exhibition_centers.name ILIKE ?', "%#{params[:exhibition_center_name]}%") if params[:exhibition_center_name].present?
    
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
