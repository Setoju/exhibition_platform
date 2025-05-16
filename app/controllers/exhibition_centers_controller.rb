class ExhibitionCentersController < ApplicationController
  before_action :authenticate_user!

  def new
    @exhibition_center = ExhibitionCenter.new
  end

  def create
    @exhibition_center = ExhibitionCenter.new(exhibition_center_params)
    if @exhibition_center.save
      redirect_to root_path, notice: 'Exhibition Center created successfully.'
    else
      render :new, alert: 'Failed to create Exhibition Center.'
    end
  end

  private

  def exhibition_center_params
    params.require(:exhibition_center).permit(:name, :address, :opening_hours, :contact_email, :contact_phone)
  end
end
