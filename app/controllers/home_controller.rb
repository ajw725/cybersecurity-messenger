# frozen_string_literal: true

class HomeController < ApplicationController # :nodoc:
  def index
    redirect_to '/index.html'
  end
end
