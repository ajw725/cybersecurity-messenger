# frozen_string_literal: true

class MessagesController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def index
    page = params[:page] || 1
    per = params[:per] || 20
    @messages = current_user.messages.order(created_at: :desc).page(page).per(per)
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
    params.require(:message).permit(:body, :recipient_username)
  end
end
