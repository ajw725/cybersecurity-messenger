# frozen_string_literal: true

module DeviseOverrides
  class SessionsController < Devise::SessionsController # :nodoc:

    private

    def after_sign_in_path_for(resource_or_scope)
      return messages_path if resource_or_scope.is_a?(User)

      stored_path = stored_location_for(resource_or_scope)
      return stored_path if stored_path.present?

      signed_in_root_path(resource_or_scope)
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end
  end
end
