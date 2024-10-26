class LoginsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    if user = authenticate(params[:username], params[:password])
      session[:current_user] = params[:username]
      redirect_to root_url
    else
      redirect_to root_url, alert: "Inloggning misslyckades."
    end
  end

  def destroy
    session.delete(:current_user)
    flash[:notice] = "Du har loggat ut."
    redirect_to root_url, status: :see_other
  end

  private

  def authenticate(username, given_password)
    actual_password = Rails.application.credentials.users[username]

    return false if actual_password.nil?

    ActiveSupport::SecurityUtils.secure_compare(given_password, actual_password)
  end
end
