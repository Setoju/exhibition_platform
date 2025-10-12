class ExhibitionsController < ApplicationController
  def index
    filtered_exhibitions = ExhibitionsFilter.new(Exhibition.all, params).apply_filters
    @exhibitions = (filtered_exhibitions || Exhibition.all)
                  .order(ExhibitionsOrder.new(params).status_order_sql)
                  .page(params[:page])
                  .per(9)
  end

  def show
    @exhibition = Exhibition.find(params[:id])
  end
end
