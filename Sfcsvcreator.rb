require "httparty"
require "nokogiri"
require "csv"
require "./Assets/spinner.rb"

class Sfcsvcreator

  def create_csv(data)
    puts ""
    puts "Creating CSV..."

    csv_headers = ["company_name", "post_title", "job_category", "part_full_time", "location", "details", "job_post_date", "apply_link"]
    spinner = Spinner.new(data.size)

    CSV.open("Silicone_forest_listing.csv", "wb", write_headers: true, headers: csv_headers, skip_blanks: true,) do |csv|
      data.each do |post|
        csv << post
        spinner.spin
      end
    end


    puts ""
    puts "CSV created and saved sucessfully!"
  end
end