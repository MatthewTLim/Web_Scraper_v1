require "httparty"
require "nokogiri"
require "csv"
require "selenium-webdriver"

class SfLinkScraper

  def initialize
    @base_url = "https://www.thesiliconforest.com/oregon-tech-jobs"
    @job_links = []
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  def retrieve_links
    @driver.get @base_url

    loop do
      scrape_current_page

      next_button = @wait.until { @driver.find_element(xpath: '/html/body/div[1]/section/div/div[3]/div/div[2]/a[2]/div')}
      break unless next_button.enabled?

      next_button.click
      sleep 3
    end
    
    puts "Scraping Complete"
    @driver.quit
    @job_links
  end

  private

  def scrape_current_page
    @html_job_links = Nokogiri::HTML(@driver.page_source).css("div.job-post-card")
    @html_job_links.each do |link|
      url = link.css("a").first.attribute("href").value
      @job_links << url
    end
  end
end