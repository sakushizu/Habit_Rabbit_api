class Api::MemosController < ApplicationController
  before_action :set_user, only: [:index, :create]

  def index
    @memo = Memo.find_by(user_id: params[:user_id], calendar_id: params[:calendar_id])
    if @memo.nil?
      return
    end
    render json: @memo
  end


  def create
    @memo = Memo.calendar_memo(params[:user_id], params[:calendar_id]).first_or_initialize
    @memo.update(memo_params)
    if @memo.save
      render nothing: :true
    else
      format.json { render json: @memo.errors, status: :unprocessable_entity }
    end
  end

  private

  def set_user
    auth_token = ApiKey.find_by(access_token: request.headers[:HTTP_ACCESS_TOKEN])
    @current_user = auth_token.user
  end

  def memo_params
    params.permit(:user_id, :calendar_id, :memo)
  end
end
