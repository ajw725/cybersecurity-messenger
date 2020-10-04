# frozen_string_literal: true

module DeviseOverrides
  class RegistrationsController < Devise::RegistrationsController # :nodoc:

    private

    def after_sign_up_path_for(*_args)
      new_user_session_path
    end

    def after_inactive_sign_up_path_for(*_args)
      new_user_session_path
    end
  end
end
