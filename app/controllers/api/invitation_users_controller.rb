class Api::InvitationUsersController < ApplicationController

  def index
    @current_user = User.find(params[:user_id])
    @calendars = Calendar.find(@current_user.invitation_users.inviting_calendar.map(&:calendar_id))
    @calendars.each do |calendar|
      calendar.users = User.find(calendar.calendar_users.map(&:user_id))
    end
  end

  def reject
    InvitationUser.change_calendar_status(params[:user_id], params[:calendar_id]).update(status: "rejected")
  end

end
