# frozen_string_literal: true

Lockbox.master_key = Rails.application.credentials.lockbox_master_key[Rails.env.to_sym]
