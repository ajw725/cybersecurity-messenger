# frozen_string_literal: true

class HealthcheckController < ApplicationController # :nodoc:
  skip_before_action :verify_authenticity_token

  def index
    head :ok
  end
end
