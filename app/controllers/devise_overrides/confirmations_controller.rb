# frozen_string_literal: true

module DeviseOverrides
  class ConfirmationsController < Devise::ConfirmationsController # :nodoc:

    private

    def after_confirmation_path_for(*_args)
      new_user_session_path
    end
  end
end
