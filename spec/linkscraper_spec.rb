require_relative '../lib/scrapers/linkscraper'

RSpec.describe LinkScraper, :vcr do
  let(:driver) { Selenium::WebDriver.for(:chrome) }
  let(:wait) { Selenium::WebDriver::Wait.new(timeout: 10) }
  let(:scraper) { PageScraper.new }
  let(:link_scraper) { LinkScraper.new(base_url: "https://www.thesiliconforest.com/oregon-tech-jobs", driver: driver, wait: wait, scraper: scraper) }

  it "retrieves job links", :vcr do
    VCR.use_cassette("retrieves_job_links") do
      job_links = link_scraper.retrieve_links
      expect(job_links.size).to be > 1
    end
  end
end