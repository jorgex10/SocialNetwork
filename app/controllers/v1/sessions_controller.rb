class V1::SessionsController < ApiV1Controller

  skip_before_filter :verify_current_user, only: :create

  def create
    if params[:email] and params[:password] and params[:device_type] and params[:uuid]
      user = User.find_by email: params[:email]
      if user and user.valid_password?(params[:password])
        device = user.devices.find_or_initialize_by(device_type: params[:device_type], uuid: params[:uuid])
        device.save if device.new_record?
        session = device.create_session
        render json: session, serializer: Sessions::ShowSerializer
      else
        render json: {
          error: "The user couldn't be found or password in invalid",
          reason: "Invalid parameters",
          suggestion: "Try again"
        }, status: :error
      end
    else
      render json: {
        error: "Missing parameters",
        reason: "Invalid parameters for search",
        suggestion: "Try again"
      }, status: :bad_request
    end
  end

end
