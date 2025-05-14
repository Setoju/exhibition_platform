class Admin::ExhibitionCentersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_exhibition_center, only: [:destroy]

  def index
    @exhibition_centers = ExhibitionCenter.all
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
      render :new
    end
  end

  def destroy
    @exhibition_center.destroy
    redirect_to exhibition_centers_path, notice: 'Exhibition center was successfully deleted.'
  end

  private

  def exhibition_center_params
    params.require(:exhibition_center).permit(:name, :address, :opening_hours, :contact_email, :contact_phone)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end

  def set_exhibition_center
    @exhibition_center = ExhibitionCenter.find(params[:id])
  end
end
