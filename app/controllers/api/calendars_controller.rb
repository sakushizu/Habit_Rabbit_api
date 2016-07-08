class Api::CalendarsController < ApplicationController
  before_action :set_user, only: [:create, :index]

  def index
    @calendars = @current_user.calendars
  end

  def create
    @calendar = @current_user.calendars.create(create_params)
    @calendar.orner = @current_user.id
    if @calendar.save
    else
      @error_message = [calendar.errors.full_messages].compact # エラーが入ってるインスタンス変数を定義
    end
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @current_user = auth_token.user
  end

  def create_params
    params.permit(:title, :color_R, :color_G, :color_B, :stamp_image)
  end
end
