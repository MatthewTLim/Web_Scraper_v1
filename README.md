# Web Scraper v1

## Description

This repository contains a Ruby-based web scraper designed for extracting data from web pages. The scraper uses several Ruby gems to facilitate HTTP requests, parse HTML content, and navigate dynamic web pages.

## Prerequisites

Before setting up the project locally, ensure you have the following installed:

- Ruby (version 3.0 or later)
- Bundler (for managing Ruby gems)

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
   
## Running the Scraper

To run the web scraper, use the following command:

```bash
ruby sfscraper.rb
```

## Gem Details

- **`nokogiri`**: This gem is used for parsing HTML and XML documents. It provides a flexible way to traverse and manipulate the content of web pages. In this project, it is used to extract specific elements and data from the HTML content fetched by `httparty`.

- **`httparty`**: HTTParty simplifies making HTTP requests and handling responses. It is used to fetch the HTML content of web pages that the scraper will then parse using `nokogiri`.

- **`dotenv`**: This gem is used to load environment variables from a `.env` file. It is helpful for managing sensitive information such as API keys or configuration settings without hardcoding them into the script.

- **`selenium-webdriver`**: Selenium WebDriver is crucial for navigating web pages and interacting with dynamic content. It allows the scraper to automate browser actions such as clicking buttons, filling out forms, and scrolling through pages. This is particularly important for websites that rely on JavaScript to load or display content.

## Selenium WebDriver Usage

Selenium WebDriver is an essential component of this scraper, especially for navigating dynamic web pages. Here’s how it’s used:

- **Navigating Pages**: Selenium WebDriver allows the scraper to open a web browser and navigate through pages programmatically. This is useful for sites that require interaction, such as clicking through pagination or navigating to different sections.

- **Handling Dynamic Content**: Many modern websites use JavaScript to load or modify content dynamically. Selenium WebDriver can wait for specific elements to appear and interact with them, ensuring that the scraper captures all relevant data.

- **Simulating User Actions**: With Selenium, you can simulate user actions such as mouse clicks and keyboard inputs. This is important for scraping content that is not immediately visible or requires user interaction to reveal.

## Troubleshooting

- **Dependencies Issues**: Ensure all gems are installed correctly. If you encounter errors, try running `bundle install` again or check for version compatibility issues.

- **Parsing Errors**: If the HTML structure of the target page changes, you may need to update your parsing logic to match the new structure.

- **Network Errors**: Check your internet connection and verify that the target URL is correct and accessible.

- **WebDriver Issues**: Ensure that you have the appropriate WebDriver for your browser installed. For example, for Chrome, you need `chromedriver`. You can download it from the [official site](https://sites.google.com/a/chromium.org/chromedriver/downloads) or install it via a package manager.

## Contributing

If you want to contribute to the project, please fork the repository and submit a pull request with your changes. Ensure that you adhere to the coding standards and include tests for any new functionality.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
--
