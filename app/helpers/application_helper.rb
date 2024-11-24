module ApplicationHelper
  def logged_in?
    session.key?(:current_user)
  end

  def current_user
    session[:current_user]
  end

  def favicon
    "📦"
  end

  def potential_packers
    Rails.application.credentials.users.keys.map(&:to_s).map(&:capitalize).sort
  end
end
