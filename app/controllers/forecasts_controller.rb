class ForecastsController < ApplicationController

  def new
  end

  def create
    #get the lat/long from the address provided
    query = params[:query]
    api_key = ENV['GEO_API_KEY'] || '65b400a85859d402123614agoe692f3'
    response = HTTParty.get("https://geocode.maps.co/search?q=#{query}&api_key=#{api_key}")

    locations = JSON.parse(response.body)

    first_location = locations.first if !locations.empty?
    #display message if there isn't a first location
    latitude = first_location["lat"] 
    longitude = first_location["lon"] 

    #get the forecast results from the API
    result = HTTParty.get("https://api.weather.gov/points/#{latitude},#{longitude}")
    url = JSON.parse(result.body)["properties"]["forecast"]

    forecast_result = HTTParty.get(url)
    puts forecast_result.body

  end

  def show
  end



end