class ApplicationController < ActionController::Base
#   before_filter :require_login
  protect_from_forgery with: :null_session
  # before_action :set_current_user

  private

  def set_current_user
    auth_token = ApiKey.find_by(access_token: request.headers[:token])
    @current_user = auth_token.user
  end

#   def not_authenticated
#     redirect_to login_path, alert: "Please login first"
#   end

end
