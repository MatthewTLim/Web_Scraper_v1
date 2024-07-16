require "httparty"
require "nokogiri"
require "csv"


response = HTTParty.get("https://www.thesiliconforest.com/oregon-tech-jobs")
@document = Nokogiri::HTML(response.body)

@html_job_links = @document.css("div.job-post-card")

JobLink = Struct.new(:url)

@job_links = []

def retrieve_links(base_url)
  counter = 0
  5.times do
    @html_job_links.each do |link|
      url = link.css("a").first.attribute("href").value
      @job_links << url
    end
    counter += 1
    next_page = "?1adb951e_page=#{counter}"
    

  end
end

self.retrieve_links(response)

JobPosting = Struct.new(:company_name, :post_title, :job_category, :part_full_time, :location, :details)

job_posts = []

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
    # add date that the job was posted as post_date

    job_posting = JobPosting.new(company_name, post_title, job_category, part_full_time, location, details)

    job_posts << job_posting
  end
end

csv_headers = ["company_name", "post_title", "job_category", "part_full_time", "location", "details"]

CSV.open("Silicone_forest_listing.csv", "wb", write_headers: true, headers: csv_headers) do |csv|
  job_posts.each do |post|
    csv << post
  end
end