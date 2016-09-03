class Api::StampedDatesController < ApplicationController
  before_action :set_user, only: [:create, :index, :destroy]

  def index
    @stamped_dates = StampedDate.stamped_dates(@current_user, params[:calendar_id])
  end

  def create
    @stamped_date = StampedDate.create(create_params)
    if @stamped_date.save
    else
      @error_message = [stamped_date.errors.full_messages].compact # エラーが入ってるインスタンス変数を定義
    end
  end

  def calendar_users_ranking
    @calendar = Calendar.find(params[:calendar_id])
    @calendar_users_ranking = @calendar.sort_users_ranking
  end

  def destroy
    StampedDate.destroy(params[:id])
    respond_to do |format|
      format.json {render json: { status: :ok } status: :ok }
    end
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers['HTTP-ACCESS-TOKEN'])
    @current_user = auth_token.user
  end

  def create_params
    params.permit(:date, :calendar_id).merge(user_id: @current_user.id)
  end
end

