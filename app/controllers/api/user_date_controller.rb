# class Api::UserDateController < ApplicationController
#   before_action :set_note, only: [:show, :edit, :update, :destroy]

#   def index
#     @dates = UserDate.accessible_by(current_ability)
#   end

#   def show
#   end

#   def new
#     @date = UserDate.new
#   end

#   def edit
#   end

#   def create
#     @date = UserDate.new(date_params.merge(user: current_user))

#     respond_to do |format|
#       if @date.save
#         format.json { render :show, status: :created, location: @date }
#       else
#         format.json { render json: @date.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   def update
#     respond_to do |format|
#       if @date.update(date_params)
#         format.json { render :show, status: :ok, location: @date }
#       else
#         format.json { render json: @date.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   def destroy
#     @date.destroy
#     respond_to do |format|
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_note
#       @date = UserDate.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def date_params
#       params.require(:user_date).permit(:user_id, :calendar_id, :tapped_date)
#     end
# end
