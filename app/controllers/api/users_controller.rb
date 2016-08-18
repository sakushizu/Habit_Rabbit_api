class Api::UsersController < ApplicationBaseController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_current_user, only: :index
  skip_before_action :require_valid_token, only: [:create, :create_with_FB, :not_joined_users]

  def index
    @users = User.all
    @users = @users.reject { |user|
      user == @current_user
    }
  end


  def not_joined_users
    calendar = Calendar.find(params[:calendar_id])
    @users = calendar.users_can_be_invited
  end

  def show
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render :create_with_FB
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create_with_FB
    @user = User.where(email: params[:user][:email]).first_or_initialize
    @user.update(fb_user_params)
    # @user.remote_avatar_url = params[:user][:avatar]
    if @user.save
      api_key = @user.activate
      @access_token = api_key.access_token
      render :create_with_FB
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :avatar)
    end

    def fb_user_params
      params.require(:user).permit(:name, :email)
    end
end
