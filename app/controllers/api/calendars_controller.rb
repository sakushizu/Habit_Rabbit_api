class Api::CalendarsController < ApplicationController
  before_action :set_user, only: [:index, :create, :update]

  def index
    @calendars = @current_user.join_calendars
    @calendars.each do |calendar|
      calendar.inviting
    end
  end

  def create
    @calendar = @current_user.calendars.new(calendar_params)
    if @calendar.save
      @calendar.calendar_users.create(user_id: @current_user.id, status: 'joined')
      @user_ids = params[:user_ids].split(",")
      @user_ids.each do |user_id|
        @calendar.calendar_users.create(user_id: user_id)
      end
    else
      @error_message = @calendar.errors.full_messages.join
    end
  end

  def update
    @calendar = @current_user.calendars.find(params[:id])
    @calendar.update_with_asocciated_users(calendar_params, params[:invitationUser_ids], params[:joined_ids])
    @calendar.calendar_users.create(user_id: @current_user.id)
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    logger.info "#{request.headers[:HTTP_ACCESS_TOKEN]}"
    @current_user = auth_token.user
  end

  def calendar_params
    params.permit(:title, :color_R, :color_G, :color_B, :stamp_image)
      .merge(user_id: @current_user.id)
  end
end
