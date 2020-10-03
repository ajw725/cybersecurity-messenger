# frozen_string_literal: true

# dumps a text file of database contents
class DatabaseDumpsController < ApplicationController
  def index
  end

  def dump
    path = DatabaseDumper.new.dump
    send_file path
  end
end
