class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_exhibitions = current_user.favourite_exhibitions.page(params[:page]).per(9)
  end

  def create
    exhibition = Exhibition.find(params[:exhibition_id])
    current_user.favourites.find_or_create_by(exhibition: exhibition)
    redirect_to exhibition, notice: "Added to favourites."
  end

  def destroy
    favourite = current_user.favourites.find_by(exhibition_id: params[:exhibition_id])
    favourite&.destroy
    redirect_to exhibition_path(params[:exhibition_id]), notice: "Removed from favourites."
  end
end
