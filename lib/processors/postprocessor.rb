require_relative "../dependencies"

class PostProcessor
  def process_post(document)
    puts "Processing job post document..."

    job_posts = []
    html_job_posting = document.css("div.w-layout-grid.grid-job-post")

    html_job_posting.each_with_index do |post, index|
      puts "Processing post #{index + 1} of #{html_job_posting.size}..."

      company_name = post.css(".job-post-company-name").text.strip
      post_title = post.css(".job-post-title").text.strip
      job_category = post.css(".job-post-category").text.strip
      part_full_time = post.css(".job-post-info-text").first.text.strip
      location = post.css(".job-post-info-text")[1].text.strip
      details = post.css(".rich-text.w-richtext").text
      job_post_date = post.xpath("/html/body/div[1]/section/div/div[2]/div[1]/div[1]/div[2]/div").text
      apply_link = post.xpath("/html/body/div[1]/section/div/div[2]/div[1]/div[3]/a").first.attribute_nodes.first.value.strip

      job_post = JobPostingPoro.new(
        company_name, post_title, job_category, part_full_time, location, details, job_post_date, apply_link
      )

      puts "Processed job post: #{post_title} from #{company_name}."

      job_posts << job_post
    end

    puts "Completed processing job post document. Found #{job_posts.size} job posts."
    job_posts
  end
end
