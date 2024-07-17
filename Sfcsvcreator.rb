require "httparty"
require "nokogiri"
require "csv"

class Sfcsvcreator

  def create_csv(data)
    csv_headers = ["company_name", "post_title", "job_category", "part_full_time", "location", "details", "job_post_date", "apply_link"]

    CSV.open("Silicone_forest_listing.csv", "wb", write_headers: true, headers: csv_headers, skip_blanks: true,) do |csv|
      data.each do |post|
        csv << post
      end
    end
  end
end