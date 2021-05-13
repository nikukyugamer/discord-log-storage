require 'csv'

class ToCsv
  def initialize
    @current_datetime_str = ARGV[0]
  end

  def execute
    filename = "log/eiyuden_discord_channels_#{@current_datetime_str}.txt"
    csv_filename = "log/eiyuden_discord_channels_#{@current_datetime_str}.csv"

    CSV.open(csv_filename, 'w', force_quotes: true) do |csv|
      File.open(filename) do |file|
        file.each_line do |line|
          csv << line.gsub(/ \| /, ',').chomp.split(",")
        end
      end
    end
  end
end

ToCsv.new.execute
