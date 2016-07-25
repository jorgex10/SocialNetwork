class V1::UsersController < ApiV1Controller

  before_action :set_user, only: :show
  skip_before_action :verify_current_user, only: [:create, :index]

  def index
    users = User.all
    render json: users
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, serializer: Users::ShowSerializer
    else
      render json: {
        error: "The user couldn't be created",
        reason: user.errors.full_messages,
        suggestion: "Try again"
      }, status: :bad_request
    end
  end

  def me
    user = current_user
    render json: user, serializer: Users::ShowSerializer
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password)
  end

  def set_user
    @user = User.find_by id: params[:id]
    unless @user
      render json: {
        error: "The user doesn't exist",
        reason: "The param id is incorrect",
        suggestion: "Try again"
      }, status: :bad_request
    end
  end
end
