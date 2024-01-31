class Forecast < ApplicationRecord

  def self.parse_zip(search_string)
    result = /\d{5}/.match(search_string)
    return result
  end

  def self.get_lat_long(query)
    api_key = ENV['GEO_API_KEY'] 
    response = HTTParty.get("https://geocode.maps.co/search?q=#{query}&api_key=#{api_key}")
    locations = JSON.parse(response.body)
    return nil if locations.size == 0
    first_location = locations.first
    latitude = first_location["lat"] 
    longitude = first_location["lon"] 

    return latitude, longitude
  end

  def self.get_forecast_url(latitude, longitude)
    result = HTTParty.get("https://api.weather.gov/points/#{latitude},#{longitude}")
    response = JSON.parse(result.body)
    url = response["properties"]["forecast"] if response["properties"]
  end
end
