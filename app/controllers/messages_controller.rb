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
    render(:new) && return unless @message.valid?

    @message.recipient_id = recipient_id
    if @message.save
      redirect_to messages_path, flash: { notice: 'Message sent.' }
    else
      render :new
    end
  rescue ActiveRecord::RecordNotFound # hide whether recipient exists
    redirect_to messages_path, flash: { notice: 'Message sent.' }
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end

  def recipient_id
    recip = User.find_by(username: params[:recipient])
    raise ActiveRecord::RecordNotFound, 'Recipient not found' unless recip

    recip.id
  end
end
