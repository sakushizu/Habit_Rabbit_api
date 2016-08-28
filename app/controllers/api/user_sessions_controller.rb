class Api::UserSessionsController < ApplicationBaseController
  skip_before_filter :require_valid_token, only: [:create, :create_with_token]

  def create
    binding.pry
    if @user = login(login_user[:email], login_user[:password])
      api_key = @user.activate
      @access_token = api_key.access_token
      @avatar_url = @user.avatar.url
    else
      respond_to do |format|
        format.json { render nothing: true, status: :not_found }
      end
    end
  end

  def create_with_token
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @user = auth_token.user
    @avatar_url = @user.avatar.url
  end

  def destroy
    access_token = request.headers[:HTTP_ACCESS_TOKEN]
    api_key = ApiKey.find_by_access_token(access_token)
    if api_key
      user = User.find(api_key.user_id)
      user.inactivate
      respond_to do |format|
        format.json { render nothing: true, status: :ok }
      end
    end
  end

  private
  def login_user
    params[:user]
  end
end
