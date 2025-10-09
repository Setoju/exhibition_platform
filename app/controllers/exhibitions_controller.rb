class ExhibitionsController < ApplicationController
  def index
    @exhibitions = Exhibition.page(params[:page]).per(9)
  end

  def show
    @exhibition = Exhibition.find(params[:id])
  end
end
