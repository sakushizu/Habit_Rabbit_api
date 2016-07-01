class Api::StampedDatesController < ApplicationController
  before_action :set_user, only: [:create, :index]

  def index
    @stamped_dates = Stamped_date.where(user_id: @current_user, calendar_id: params[:calendar_id])
  end

  def create
    @stamped_date = StampedDate.create(create_params)
    if @stamped_date.save
    else
      @error_message = [stamped_date.errors.full_messages].compact # エラーが入ってるインスタンス変数を定義
    end
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @current_user = auth_token.user
  end

  def create_params
    params.permit(:date, :calendar_id).merge(user_id: @current_user.id)
  end
end
