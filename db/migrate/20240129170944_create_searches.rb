class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :query
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
