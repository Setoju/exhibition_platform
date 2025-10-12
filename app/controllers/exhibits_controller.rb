class ExhibitsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @exhibits = Exhibit.all
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
      redirect_to @exhibition, notice: "Exhibit was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :width, :height, :depth, :weight, :creation_date, :exhibition_type_id, :room_id, :material, :copy, :artist_name, :artist_biography, :artist_contact_email, :artist_contact_phone, photos: [])
  end
end
