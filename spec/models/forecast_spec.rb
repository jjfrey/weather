require 'rails_helper'

RSpec.describe Forecast, type: :model do
  context "#parse_zip" do 
    it "returns the zipcode when found" do 
      expect(described_class.parse_zip("44444").to_s).to eq("44444")
    end

    it "returns empty string when a zipcode is not found" do 
      expect(described_class.parse_zip("foo").to_s).to eq("")
    end

  end

  context "#get_lat_long" do 
    it "returns a latitude and longitude for a valid search" do 
      VCR.use_cassette("get_lat_long_success") do
        lat,long = described_class.get_lat_long("Akron, Ohio 44320")
        expect(lat).to eq("41.083064")
        expect(long).to eq("-81.518485")
      end
    end

    it "returns nil for an invalid search" do 
      VCR.use_cassette("get_lat_long_fail") do
        lat,long = described_class.get_lat_long("iiiiiwwwwwiiiii")
        expect(lat).to eq(nil)
      end
    end
  end

  context "#get_forecast_url" do 
    it "returns a latitude and longitude for a valid search" do 
      VCR.use_cassette("get_forecast_success") do
        url = described_class.get_forecast_url("41.083064","-81.518485")
        expect(url).to eq("https://api.weather.gov/gridpoints/CLE/91,47/forecast")
      end
    end
  end
end
