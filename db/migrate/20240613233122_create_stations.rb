class CreateStations < ActiveRecord::Migration[7.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :status
      t.references :location, foreign_key: true
      t.references :warehouse, foreign_key: true

      t.timestamps
    end
  end
end
