require "httparty"
require "nokogiri"
require "csv"
require "./Assets/spinner.rb"
require_relative "Jobpostingporo"
require "./Assets/spinner.rb"

class SfPostScraper

  def initialize(job_links)
    @job_links = job_links
    @job_posts = []
  end

  def scrape_posts

    spinner = Spinner.new(@job_links.size)

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
        job_post_date = post.xpath("/html/body/div[1]/section/div/div[2]/div[1]/div[1]/div[2]/div").text
        apply_link = post.xpath("/html/body/div[1]/section/div/div[2]/div[1]/div[3]/a").first.attribute_nodes.first.value.strip

        job_posting = JobPostingPoro.new(
          company_name,
          post_title,
          job_category,
          part_full_time,
          location,
          details,
          job_post_date,
          apply_link
          )

        @job_posts << job_posting
        spinner.spin
      end
    end
    @job_posts
  end
end