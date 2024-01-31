class ForecastsController < ApplicationController

  def new
    @forecast = Forecast.new
  end

  def create
    query = params[:forecast][:query]
    zipcode = Forecast.parse_zip(query)

    if zipcode.blank?
      flash[:zip_error] = "zipcode was not provided"
      @forecast = Forecast.new(query: query)
      render action: "new"
      return false
    end

    latitude, longitude = Forecast.get_lat_long(query)

    if latitude.blank?
      flash[:result_error] = "no results returned"
      @forecast = Forecast.new(query: query)
      render action: "new"
      return false
    end

    url = Forecast.get_forecast_url(latitude, longitude)

    if url.blank?
      flash[:result_error] = "no results returned"
      @forecast = Forecast.new(query: query)
      render action: "new"
      return false
    end

    @forecast = Forecast.create(
      latitude: latitude, 
      longitude: longitude,
      query: query,
      zipcode: zipcode,
      url: url
    ) 

    redirect_to(@forecast)
  end

  def show
    @forecast = Forecast.find(params[:id])
    result = HTTParty.get(@forecast[:url])
    @forecast_results = JSON.parse(result.body)["properties"]["periods"]
  end
  
end