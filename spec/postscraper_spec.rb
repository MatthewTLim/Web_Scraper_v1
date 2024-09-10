require_relative '../lib/scrapers/postscraper'
require_relative './support/mock_data'

RSpec.describe PostScraper, :vcr do
  let(:mock_links) { mock_csv_data.map { |row| row["apply_link"] } }
  let(:http_client) { HTTParty }
  let(:parser) { Nokogiri }
  let(:post_processor) { PostProcessor.new }
  let(:post_scraper) { PostScraper.new(mock_links, http_client: http_client, parser: parser, post_processor: post_processor) }
  let(:expect_job_posts) { mock_details }

  it "scrapes job details from job links" do
    job_posts = post_scraper.scrape_posts
    expect(job_posts).not_to be_empty
    expect(job_posts.size).to eq(10)

  end
end
