require_relative "../dependencies"

class PostScraper
  def initialize(job_links, http_client:, parser:, post_processor:)
    @job_links = job_links
    @http_client = http_client
    @parser = parser
    @post_processor = post_processor
    @job_posts = []
  end

  def scrape_posts
    puts "Starting to scrape job posts from #{@job_links.size} job links..."

    @job_links.each_with_index do |link, index|
      puts "Scraping job post #{index + 1} of #{@job_links.size}: #{link}"
      response = @http_client.get("https://www.thesiliconforest.com/#{link}")
      document = @parser.HTML(response.body)
      posts = @post_processor.process_post(document)
      puts "#{posts.size} job posts found on page #{index + 1}."
      @job_posts.concat(posts)
    end

    puts "Job posts scraping completed. Total job posts scraped: #{@job_posts.size}."
    @job_posts
  end
end
