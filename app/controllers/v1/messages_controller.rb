class V1::MessagesController < ApiV1Controller

  def create
    message = Message.new(message_params)
    message.sender = current_user
    if message.valid?
      message.save
      receivers = params[:receivers].tr('[]', '').split(',').map(&:to_i)
      receivers.each do |receiver|
        UserMessage.create(user_id: receiver, message: message)
      end
      render json: message, serializer: Messages::ShowSerializer
    else
      render json: {
        error: "Message couldn't be created",
        reason: @message.errors.full_messages,
        suggestion: "Try again"
      }, status: :error
    end
  end

  def show
    message = Message.find params[:id]
    if message.can_show? current_user
      message.read! current_user if message.is_receiver? current_user
      render json: message, serializer: Messages::ShowSerializer if message.is_receiver? current_user
      render json: message, serializer: Messages::ShowBySenderSerializer if message.is_sender? current_user
    else
      render json: {
        error: "You don't have permissions for this action",
        reason: "You are not sender or receiver for this message",
        suggestion: "Redirect you to another message"
      }, status: :error
    end
  end

  def sent
    messages = current_user.sent_messages
    render json: messages
  end

  def unread
    messages = current_user.unread_messages
    render json: messages
  end

  def read
    messages = current_user.read_messages
    render json: messages
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

end
