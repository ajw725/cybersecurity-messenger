# frozen_string_literal: true

module DeviseOverrides
  class RegistrationsController < Devise::RegistrationsController # :nodoc:

    skip_before_action :require_no_authentication, only: :new

    def new
      if user_signed_in?
        redirect_to messages_path, flash: { alert: 'You are already signed in.' }
        return
      end

      super
    end

    private

    def after_sign_up_path_for(*_args)
      new_user_session_path
    end

    def after_inactive_sign_up_path_for(*_args)
      new_user_session_path
    end
  end
end
