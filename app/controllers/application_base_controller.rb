class ApplicationBaseController < ApplicationController
  before_action :require_valid_token

  private

  def require_valid_token
    access_token = request.headers[:HTTP_ACCESS_TOKEN]
    if !User.login?(access_token)
      render json: { status: :unauthorized }, status: :unauthorized
    end
  end

  def set_current_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @current_user = auth_token.user
  end

end
