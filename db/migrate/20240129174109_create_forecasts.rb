class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :query
      t.string :url
      t.string :latitude
      t.string :longitude
      t.string :zipcode
      t.timestamps
    end
  end
end
