require_relative "./lib/dependencies"

class CsvCreator
  def initialize(csv_writer:, file_name: "Silicone_forest_listing.csv")
    @csv_writer = csv_writer
    @file_name = file_name
  end

  def create_csv(data, headers)
    puts "Creating CSV file: #{@file_name}"
    @csv_writer.open(@file_name, "wb", write_headers: true, headers: headers, skip_blanks: true) do |csv|
      data.each_with_index do |post, index|
        puts "Writing job post #{index + 1} of #{data.size} to CSV..."
        csv << post
      end
    end
    puts "CSV file created successfully: #{@file_name}."
  end
end
