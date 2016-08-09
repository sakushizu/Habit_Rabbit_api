class Api::CalendarsController < ApplicationController
  before_action :set_user, only: [:create, :index]

  def index
    @calendars = @current_user.calendars
    @calendars.each do |calendar|
      calendar.users = User.find(calendar.calendar_users.map(&:user_id))
    end
  end

  def create
    @calendar = @current_user.calendars.new(calendar_params)
    if @calendar.save
      @calendar.calendar_users.create(user_id: @current_user.id)
      @user_ids = params[:user_ids].split(",")
      @user_ids.each do |user_id|
        @calendar.invitation_users.create(user_id: user_id)
      end
    else
      @error_message = calendar.errors.full_messages.join
    end
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @current_user = auth_token.user
  end

  def calendar_params
    params.permit(:title, :color_R, :color_G, :color_B, :stamp_image)
      .merge(user_id: @current_user.id)
  end
end
