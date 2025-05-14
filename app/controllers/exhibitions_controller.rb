class ExhibitionsController < ApplicationController
  def index
    @exhibitions = Exhibition.all
  end

  def show
    @exhibition = Exhibition.find(params[:id])
  end

  def new
    @exhibition = Exhibition.new
  end

  def create
    @exhibition = Exhibition.new(exhibition_params)
    if @exhibition.save
      redirect_to @exhibition, notice: 'Exhibition created successfully.'
    else
      render :new
    end
  end

  private

  def exhibition_params
    params.require(:exhibition).permit(:name, :description, :exhibition_center_id, 
                                     :exhibition_type_id, :room_id, :start_date, :end_date)
  end
end
