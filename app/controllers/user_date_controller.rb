class UserDateController < ApplicationController
  load_and_authorize_resource
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # accessible_byでアクセスを制限
  def index
    @dates = UserDate.accessible_by(current_ability)
  end

  def show
  end

  def new
    @date = UserDate.new
  end

  def edit
  end

  def create
    # ノートの作成者を設定
    @date = UserDate.new(date_params.merge(user: current_user))

    respond_to do |format|
      if @date.save
        format.html { redirect_to @date, notice: 'Date was successfully created.' }
        format.json { render :show, status: :created, location: @date }
      else
        format.html { render :new }
        format.json { render json: @date.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @date.update(date_params)
        format.html { redirect_to @date, notice: 'Date was successfully updated.' }
        format.json { render :show, status: :ok, location: @date }
      else
        format.html { render :edit }
        format.json { render json: @date.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @date.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @date = UserDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def date_params
      params.require(:user_date).permit(:user_id, :calendar_id, :tapped_date)
    end
end
