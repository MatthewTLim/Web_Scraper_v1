require_relative "lib/dependencies"

def main
  puts "Starting the scraper..."

  driver = initialize_driver
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  page_scraper = PageScraper.new
  link_scraper = LinkScraper.new(
    base_url: "https://www.thesiliconforest.com/oregon-tech-jobs",
    driver: driver,
    wait: wait,
    scraper: page_scraper
  )

  job_links = link_scraper.retrieve_links
  if job_links.empty?
    puts "No job links retrieved."
    return
  end
  puts "Total job links retrieved: #{job_links.size}"

  http_client = HTTParty
  parser = Nokogiri
  post_processor = PostProcessor.new

  post_scraper = PostScraper.new(job_links, http_client: http_client, parser: parser, post_processor: post_processor)
  job_posts = post_scraper.scrape_posts

  if job_posts.empty?
    puts "No job posts scraped."
    return
  end
  puts "Job details scraping complete. Found #{job_posts.size} job posts."

  csv_creator = CsvCreator.new(csv_writer: CSV)
  csv_headers = ["company_name", "post_title", "job_category", "part_full_time", "location", "details", "job_post_date", "apply_link"]
  csv_creator.create_csv(job_posts, csv_headers)
  puts "CSV file created successfully."

  puts "Scraper finished successfully!"
end

def initialize_driver
  Selenium::WebDriver.for(:chrome)
end

if __FILE__ == $PROGRAM_NAME
  begin
    main
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    puts e.backtrace
  end
end
