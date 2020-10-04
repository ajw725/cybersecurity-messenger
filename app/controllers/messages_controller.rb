# frozen_string_literal: true

class MessagesController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def index
    @messages = current_user.messages
    @sent_messages = current_user.sent_messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.save!
    redirect_to messages_path, flash: { notice: 'Message sent.' }
  rescue Message::InvalidRecipientError # hide whether recipient exists
    redirect_to messages_path, flash: { notice: 'Message sent.' }
  rescue
    render :new
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :recipient_username)
  end
end
