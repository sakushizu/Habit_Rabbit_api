class Api::CalendarsController < ApplicationController
  before_action :set_user, only: [:index, :create, :update]

  def index
    @calendars = @current_user.calendars
    @calendars.each do |calendar|
      calendar.joined_users = calendar.joined_users.reject { |user|
        user == @current_user
      }
      calendar.invitation_users = calendar.invitation_users.where(status: 'inviting')
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

  def update
    @calendar = @current_user.calendars.find(params[:id])
    @calendar.update(calendar_params)
    @calendar.invitation_users.where(status: 'inviting').destroy_all
    unless params[:invitationUser_ids].empty?
      invitationUser_ids = params[:invitationUser_ids].split(",")
      invitationUser_ids.each do |user_id|
        @calendar.invitation_users.create(user_id: user_id)
      end
    end

    @calendar.calendar_users.destroy_all
    @calendar.invitation_users.where(status: InvitationUser.statuses['joined']).destroy_all
    unless params[:joined_ids].empty?
      joined_ids = params[:joined_ids].split(",")
      joined_ids.each do |user_id|
        @calendar.calendar_users.create(user_id: user_id)
      end
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
