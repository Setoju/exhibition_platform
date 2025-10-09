class Admin::ExhibitionCentersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_exhibition_center, only: [:destroy, :edit, :update]

  def index
    @exhibition_centers = apply_filters(ExhibitionCenter.all)
                         .page(params[:page])
                         .per(5)
  end

  def show
    @exhibition_center = ExhibitionCenter.find(params[:id])
    @rooms = @exhibition_center.rooms
  end

  def new
    @exhibition_center = ExhibitionCenter.new
  end    
  def create
    @exhibition_center = ExhibitionCenter.new(exhibition_center_params)
    if @exhibition_center.save
      redirect_to admin_exhibition_centers_path, notice: 'Exhibition center created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @exhibition_center = ExhibitionCenter.find(params[:id])
  end

  def update
    @exhibition_center = ExhibitionCenter.find(params[:id])    
    if @exhibition_center.update(exhibition_center_params)
      redirect_to admin_exhibition_centers_path, notice: 'Exhibition center updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exhibition_center.destroy
    redirect_to admin_exhibition_centers_path, notice: 'Exhibition center was successfully deleted.'
  end

  private

  def exhibition_center_params
    params.require(:exhibition_center).permit(:name, :address, :opening_hours, :contact_email, :contact_phone)
  end

  def set_exhibition_center
    @exhibition_center = ExhibitionCenter.find(params[:id])
  end

  def apply_filters(scope)
    scope = scope.where('name ILIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
    scope = scope.where('address ILIKE ?', "%#{params[:search_address]}%") if params[:search_address].present?
    
    if params[:search_contact].present?
      contact_search = "%#{params[:search_contact]}%"
      scope = scope.where('contact_email ILIKE ? OR contact_phone ILIKE ?', contact_search, contact_search)
    end
    
    scope
  end
end
