# frozen_string_literal: true

module DeviseOverrides
  class SessionsController < Devise::SessionsController # :nodoc:

    private

    def after_sign_in_path_for(resource_or_scope)
      stored_path = stored_location_for(resource_or_scope)
      return stored_path if stored_path.present?
      return messages_path if resource_or_scope.is_a?(User)

      signed_in_root_path(resource_or_scope)
    end
  end
end
