class ApiV1Controller < ApplicationController

  respond_to :json
  before_action :verify_current_user

  def verify_current_user
    token = request.headers["HTTP_AUTHORIZATION"]
    unless token.blank?
      session ||= Session.find_by_access_token(token)
      if session and !session.expired?
        @current_user = session.device.user
      else
        render json: { error: "Your session as expired, please create another session" }, status: :error
        return
      end
      render json: { error: "You are unauthorized to perform this action" }, status: 401 if @current_user.nil?
    else
      render json: { error: "HTTP_AUTHORIZATION is missing" }, status: :bad_request
    end
  end

  private

  def current_user
    @current_user
  end

end
