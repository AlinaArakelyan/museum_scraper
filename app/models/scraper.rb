require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def scrape_city_urls
         ny_url = 'http://www.museumsusa.org/museums/?k=1271400%2cState%3aNY%3bDirectoryID%3a200454'

        html = open(ny_url)
         #returns the html from the page

          doc = Nokogiri::HTML(html)
         #Nokogiri html method takes html as argument and returns it as a set of nodes

         cities = doc.css('#city').css('.browseCategoryItem')
         #selects all the cities 
         binding.pry
    end 
end

scrape = Scraper.new
scrape.scrape_city_urls