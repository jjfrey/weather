class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.references :search
      t.string :url
      t.timestamps
    end
  end
end
