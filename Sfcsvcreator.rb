require "httparty"
require "nokogiri"
require "csv"

class Sfcsvcreator

  def create_csv(data)
    csv_headers = ["company_name", "post_title", "job_category", "part_full_time", "location", "details"]

    CSV.open("Silicone_forest_listing.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
      data.each do |post|
        csv << post
      end
    end
  end
end