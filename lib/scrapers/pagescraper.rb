require_relative "../dependencies"

class PageScraper
  def scrape_page(html)
    puts "Processing page HTML to extract job links..."
    job_links = []
    html_job_links = Nokogiri::HTML(html).css("div.job-post-card")
    html_job_links.each do |link|
      url = link.css("a").first.attribute("href").value
      job_links << url
    end
    puts "#{job_links.size} job links found on this page."
    job_links
  end
end
