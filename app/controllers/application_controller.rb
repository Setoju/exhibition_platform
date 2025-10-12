class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
