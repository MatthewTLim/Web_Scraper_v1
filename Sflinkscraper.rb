require "httparty"
require "nokogiri"
require "csv"

class SfLinkScraper

  def initialize
    @response = HTTParty.get("https://www.thesiliconforest.com/oregon-tech-jobs")
    @document = Nokogiri::HTML(@response.body)
    @html_job_links = @document.css("div.job-post-card")
    @JobLink = Struct.new(:url)
    @job_links = []
  end

  def retrieve_links
    @html_job_links.each do |link|
      url = link.css("a").first.attribute("href").value
      @job_links << url
    end
    @job_links
  end
end