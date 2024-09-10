require 'csv'

def mock_csv_data
  path = File.join(File.dirname(__FILE__), '../../data/Silicone_forest_listing.csv')
  CSV.read(path, headers: true).first(10).map(&:to_h)
end

def mock_details
  mock_csv_data.map do |row|
    JobPostingPoro.new(
      row["company_name"],
      row["post_title"],
      row["job_category"],
      row["part_full_time"],
      row["location"],
      row["details"],
      row["job_post_date"],
      row["apply_link"]
    )
  end
end
