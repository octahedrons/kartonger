module ApplicationHelper
  def logged_in?
    session.key?(:current_user)
  end

  def current_user
    session[:current_user]
  end
end
