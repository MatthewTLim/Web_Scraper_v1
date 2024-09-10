require 'csv'

def mock_csv_data
  path = File.join(File.dirname(__FILE__), '../data/Silicone_forest_listing.csv')
  CSV.read(path, headers: true).first(10).map(&:to_h)
end
