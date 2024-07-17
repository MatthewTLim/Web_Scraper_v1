require_relative "Sfcsvcreator"
require_relative "Sflinkscraper"
require_relative "Sfpostscraper"

link_scraper = SfLinkScraper.new
csv_creator = Sfcsvcreator.new
job_links = link_scraper.retrieve_links
post_scraper = SfPostScraper.new(job_links)
job_posts = post_scraper.scrape_posts
csv_creator.create_csv(job_posts)