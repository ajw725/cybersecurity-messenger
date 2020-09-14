# frozen_string_literal: true

class MessagesController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def index
    @messages = current_user.messages
    @sent_messages = current_user.sent_messages
  end
end
