class Api::CalendarUsersController < ApplicationController

  def inviting_calendar
    @current_user = User.find(params[:user_id])
    @calendars = @current_user.inviting_calendars_include_join_users
  end

  def create
    @current_user = User.find(params[:user_id])
    @calendar = @current_user.update_calendar('joined', params[:calendar_id])
  end

  def reject
    @current_user = User.find(params[:user_id])
    @current_user.update_calendar('rejected', params[:calendar_id])
    render nothing: :true
  end

end
