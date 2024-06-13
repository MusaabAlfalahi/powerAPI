class CreatePowerBanks < ActiveRecord::Migration[7.1]
  def change
    create_table :power_banks do |t|
      t.string :identifier
      t.string :status
      t.references :station, foreign_key: true
      t.references :warehouse, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
