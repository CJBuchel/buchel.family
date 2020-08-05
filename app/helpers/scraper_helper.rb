# Used for scraping
require 'nokogiri'
require 'httparty'
require 'byebug'

module ScraperHelper

  def scraperFunc
    url = "https://www.reddit.com/r/memes/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)

    listing_Posts = parsed_page.css()
    # byebug
  end
end
