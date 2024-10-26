class ApplicationController < ActionController::Base
  before_action :require_login

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def require_login
    redirect_to login_url unless helpers.logged_in?
  end
end
