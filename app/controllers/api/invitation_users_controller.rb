class Api::InvitationUsersController < ApplicationController
  # before_action :set_user, only: :index


  def index
    @current_user = User.find(params[:user_id])
    binding.pry
    @calendars = Calendar.find(@current_user.invitation_users.map(&:calendar_id))
  end

  private

  # def set_user
  # auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
  # @current_user = auth_token.user

end
