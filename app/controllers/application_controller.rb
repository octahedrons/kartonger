class ApplicationController < ActionController::Base
  before_action :require_login

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  # commenting out the above line makes it possible to use the devices toolbar in browser developer tools
  # https://discuss.rubyonrails.org/t/help-rails-hello-world-complains-of-your-browser-is-not-supported-please-upgrade-your-browser-to-continue-when-displaying-simple-html/86744
  # https://github.com/rails/rails/issues/52534
  # https://github.com/rails/rails/pull/50505#issuecomment-1894487201
  # https://github.com/rails/rails/issues/50981
  # https://github.com/rails/rails/pull/52538

  private

  def require_login
    redirect_to login_url unless helpers.logged_in?
  end
end
