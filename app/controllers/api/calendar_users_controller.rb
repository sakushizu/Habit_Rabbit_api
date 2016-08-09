class Api::CalendarUsersController < ApplicationController

  def create
    CalendarUser.create(calendarUser_params)
    InvitationUser.change_calendar_status(params[:user_id], params[:calendar_id]).update(status: "joined")
    @calendar = Calendar.find(params[:calendar_id])
  end

  private

  def calendarUser_params
    params.permit(:calendar_id, :user_id)
  end
end
