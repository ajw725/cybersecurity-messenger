# frozen_string_literal: true

Rails.application.config.session_store :cookie_store,
                                       key: '_messenger_session',
                                       same_site: :strict,
                                       httponly: true
