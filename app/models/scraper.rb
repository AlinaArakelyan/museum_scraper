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
         cities = doc.css('#city').css('.browseCategoryItem').css('a')
         #selects all the cities 
         city_urls = []

         cities.each do |city|
            url = city.attribute('href').value
            city_urls << url
         end 

        scrape_city_pages(city_urls)
    end 

    def scrape_city_pages(city_urls)
        museums_list = []

        city_urls.each do |city_url|
            url = "http://www.museumsusa.org#{city_url}"
            html = open(url)
            doc = Nokogiri::HTML(html)

            museums_list << doc.css('.itemGroup').css('.item').css('.basic')
        end

        create_museums(museums_list)
    end

    def create_museums(museums_list)
        museums = []

        museums_list.each do |museum|
            name = museum.css('.source').css('a').text
            location = museum.css('.location').text.split(', ')
            type = museum.css('.type').text
            desc = museum.css('.abstract').text

            museum_info = {
                name: name,
                city: location[0],
                state: location[1],
                categories: type,
                description: desc
            }

            museums << museum_info
        end 

        museums

    end 

end

scrape = Scraper.new
scrape.scrape_city_urls