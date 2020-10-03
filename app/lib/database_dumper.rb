# frozen_string_literal: true

require 'csv'

# dump database contents to CSV file
class DatabaseDumper
  def dump
    CSV.open(temp_path, 'wb') do |csv|
      tables.each do |table|
        csv << [table]
        csv << columns(table)

        data = conn.execute("SELECT * FROM #{table}")
        if data.count.zero?
          csv << ['-']
          next
        end

        data.each { |row| csv << row.values }
        csv << ['-']
      end
    end

    temp_path
  end

  private

  def temp_dir
    return @temp_dir if defined?(@temp_dir)

    @temp_dir = Rails.root.join('tmp', SecureRandom.uuid)
    FileUtils.mkdir_p @temp_dir
    @temp_dir
  end

  def temp_path
    return @temp_path if defined?(@temp_path)

    @temp_path = Rails.root.join(temp_dir, 'db_dump.csv')
  end

  def conn
    @conn ||= ActiveRecord::Base.connection
  end

  def tables
    @tables ||= conn.tables.reject do |table_name|
      %w[schema_migrations ar_internal_metadata].include?(table_name)
    end.sort
  end

  def columns(table)
    conn.columns(table).map { |col| "#{col.name} (#{col.sql_type})" }
  end
end
