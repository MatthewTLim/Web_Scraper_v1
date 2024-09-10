require "httparty"
require "nokogiri"
require "csv"
require "selenium-webdriver"
require "./Assets/spinner.rb"

class SfLinkScraper

  def initialize
    @base_url = "https://www.thesiliconforest.com/oregon-tech-jobs"
    @job_links = []
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
  end

  def retrieve_links
    puts "Retrieving links..."
    @driver.get @base_url
    spinner = Spinner.new(0)

    begin
      loop do
        scrape_current_page

        next_button = @wait.until { @driver.find_element(xpath: '/html/body/div[1]/section/div/div[3]/div/div[2]/a[2]/div')}
        break unless next_button.enabled?

        begin
          next_button.click
        rescue Selenium::WebDriver::Error::ElementClickInterceptedError, Selenium::WebDriver::Error::ElementNotInteractableError => e
          puts "Error clicking next button: #{e.message}"
          break
        end

        spinner.spinner_only
      sleep 3
    end

    puts "Scraping Complete"
    ensure
      @driver.quit
    end

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
