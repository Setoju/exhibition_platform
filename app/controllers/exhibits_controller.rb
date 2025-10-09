class ExhibitsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @exhibits = apply_filters(Exhibit.all)
               .page(params[:page])
               .per(12)
  end

  def show
    @exhibit = Exhibit.find(params[:id])
  end

  def new
    @exhibition = Exhibition.find(params[:exhibition_id])
    @exhibit = @exhibition.exhibits.build
  end

  def create
    @exhibition = Exhibition.find(params[:exhibition_id])
    @exhibit = @exhibition.exhibits.build(exhibit_params)
    
    if @exhibit.save
      redirect_to @exhibition, notice: 'Exhibit was successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :width, :height, :depth, :weight, :creation_date, :exhibition_type_id, :room_id, :material, :copy, :artist_name, :artist_biography, :artist_contact_email, :artist_contact_phone, photos: [])
  end

  def apply_filters(scope)
    scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
    scope = scope.where('material ILIKE ?', "%#{params[:search_material]}%") if params[:search_material].present?
    scope = scope.joins(exhibition: :exhibition_center).where('exhibition_centers.name ILIKE ?', "%#{params[:exhibition_center_name]}%") if params[:exhibition_center_name].present?
    scope = scope.joins(:exhibition).where('exhibitions.name ILIKE ?', "%#{params[:exhibition_name]}%") if params[:exhibition_name].present?
    scope = scope.where(copy: params[:copy]) if params[:copy].present?
    
    if params[:min_width].present?
      scope = scope.where('width >= ?', params[:min_width])
    end
    
    if params[:max_width].present?
      scope = scope.where('width <= ?', params[:max_width])
    end
    
    scope
  end
end
