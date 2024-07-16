require "httparty"
require "nokogiri"
require "csv"
require_relative "Jobpostingporo"

class SfPostScraper

  def initialize(job_links)
    @job_links = job_links
    @job_posts = []
  end

  def scrape_posts
    @job_links.each do |link|
      response = HTTParty.get("https://www.thesiliconforest.com/#{link}")
      document = Nokogiri::HTML(response.body)
      html_job_posting = document.css("div.w-layout-grid.grid-job-post")

      html_job_posting.each do |post|
        company_name = post.css(".job-post-company-name").text.strip
        post_title = post.css(".job-post-title").text.strip
        job_category = post.css(".job-post-category").text.strip
        part_full_time = post.css(".job-post-info-text").first.text.strip
        location = post.css(".job-post-info-text")[1].text.strip
        details = post.css(".rich-text.w-richtext").text


        job_posting = JobPostingPoro.new(company_name, post_title, job_category, part_full_time, location, details)

        @job_posts << job_posting
      end
    end
    @job_posts
  end
end

# JobPosting = Struct.new(:company_name, :post_title, :job_category, :part_full_time, :location, :details)