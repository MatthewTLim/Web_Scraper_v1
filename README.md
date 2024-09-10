# Web Scraper v1

## Description

This repository contains a Ruby-based web scraper designed for extracting data from web pages. The scraper uses several Ruby gems to facilitate HTTP requests, parse HTML content, and navigate dynamic web pages. The project has been structured for modularity and simplicity, with responsibilities divided across separate classes for scraping, processing, and file creation.

## Prerequisites

Before setting up the project locally, ensure you have the following installed:

- Ruby (version 3.0 or later)
- Bundler (for managing Ruby gems)
- ChromeDriver (for Selenium WebDriver)

## Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/MatthewTLim/Web_Scraper_v1.git
   cd Web_Scraper_v1
   ```

2. **Install Dependencies**

   Install the required gems using Bundler:

   ```bash
   bundle install
   ```

3. **Install ChromeDriver**

   Selenium WebDriver requires a browser driver. For Chrome, you need to install `chromedriver`:

   - **macOS**:
     ```bash
     brew install chromedriver
     ```

   - **Ubuntu**:
     ```bash
     sudo apt-get install chromium-chromedriver
     ```

   - **Windows**:
     Download it from [ChromeDriver's official site](https://sites.google.com/a/chromium.org/chromedriver/downloads) and add it to your PATH.

## Running the Scraper

To run the web scraper, use the following command:

```bash
ruby run.rb
```

The scraper will automatically:
- Open Chrome via Selenium WebDriver.
- Navigate through multiple pages of job listings.
- Extract job details such as company name, job title, location, etc.
- Save the job listings to a CSV file (`Silicone_forest_listing.csv`).

### Project Structure

The scraper has been divided into several key components:

1. **Scrapers**: Handles the web scraping logic.
   - `LinkScraper`: Scrapes job listing URLs from the main site.
   - `PageScraper`: Scrapes job listings on individual pages.
   - `PostScraper`: Uses both `LinkScraper` and `PageScraper` to gather job data.
   
2. **Processors**: Processes and formats the scraped data.
   - `PostProcessor`: Extracts and processes job details from each scraped job page.
   
3. **CSV Creator**: Handles writing the scraped data into a CSV file.
   - `CsvCreator`: Takes processed job posts and writes them to a CSV file.

4. **Poro**: Contains simple data structures.
   - `JobPostingPoro`: A plain old Ruby object to represent a job posting with attributes like company name, job title, etc.

5. **`run.rb`**: This is the entry point to the scraper. It initializes all dependencies and runs the scraper in a step-by-step process.

### How Each Component Works

- **`run.rb`**: 
  - This file contains the main execution flow. It initializes the scrapers, processors, and CSV creator, running them in sequence.
  - It centralizes error handling and simplifies the control flow by removing unnecessary abstractions like logging.

- **`LinkScraper`, `PageScraper`, and `PostScraper`**:
  - These classes handle different parts of scraping. `LinkScraper` gathers all job links, while `PageScraper` processes individual pages. `PostScraper` combines them to collect job details.

- **`CsvCreator`**:
  - Once all job posts are collected and processed, this class generates a CSV file. The file is saved in the `/data` folder.

## Gem Details

- **`nokogiri`**: Used for parsing HTML content. It allows the scraper to easily extract specific elements from web pages.
- **`httparty`**: Simplifies making HTTP requests. It’s used in tandem with Nokogiri to fetch and parse web pages.
- **`selenium-webdriver`**: Allows interaction with dynamic content, such as clicking buttons and navigating paginated job listings. This is crucial for scraping sites that rely on JavaScript.
- **`csv`**: Used to generate the CSV file with the scraped job data.

## Selenium WebDriver Usage

Selenium WebDriver is essential for navigating and scraping websites with dynamic content. Here's how it's used:

- **Automating Browser Actions**: Selenium opens Chrome and mimics user interactions, such as clicking through pagination links, which allows the scraper to gather data from multiple pages.
- **Handling JavaScript-Driven Content**: Many modern websites use JavaScript to load data dynamically. Selenium WebDriver ensures that all content is fully loaded before scraping begins.

## Troubleshooting

- **Gem Issues**: If you encounter issues related to dependencies, ensure all gems are installed correctly using `bundle install`. Double-check for any version compatibility issues.
- **Selenium Issues**: Make sure you have ChromeDriver installed and configured correctly. If Selenium can’t open the browser, verify that ChromeDriver is installed in your PATH.
- **Parsing Errors**: If the structure of the target web pages changes, the scraper’s parsing logic (Nokogiri CSS selectors) may need to be updated.

## Contributing

If you want to contribute to the project, feel free to fork the repository and submit a pull request with your changes. Please ensure that your code adheres to the coding standards and includes tests for any new functionality.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
