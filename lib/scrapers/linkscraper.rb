require_relative "../dependencies"

class LinkScraper
  def initialize(base_url:, driver:, wait:, scraper:)
    @base_url = base_url
    @driver = driver
    @wait = wait
    @scraper = scraper
    @job_links = []
  end

  def retrieve_links
    puts "Starting link scraping from #{@base_url}..."

    @driver.get(@base_url)
    puts "Navigated to #{@base_url}"

    begin
      loop do
        puts "Scraping current page for job links..."
        page_links = @scraper.scrape_page(@driver.page_source)
        puts "Found #{page_links.size} links on current page."
        @job_links.concat(page_links)

        next_button = @wait.until { @driver.find_element(xpath: '/html/body/div[1]/section/div/div[3]/div/div[2]/a[2]/div') }
        if next_button.enabled?
          puts "Clicking next button to load more job postings..."
          begin
            next_button.click
          rescue Selenium::WebDriver::Error::ElementClickInterceptedError, Selenium::WebDriver::Error::ElementNotInteractableError => e
              puts "Error clicking next button: #{e.message}. Stopping scraping process."
              break
          end
        else
          puts "Next button is disabled. No more pages to scrape."
          break
        end

        sleep 3
      end
    ensure
      puts "Closing the browser..."
      @driver.quit
    end

    puts "Scraping complete. Total links found: #{@job_links.size}"
    @job_links
  end
end
