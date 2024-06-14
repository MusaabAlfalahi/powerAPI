class RenameidentiferToName < ActiveRecord::Migration[7.1]
  def change
    rename_column :power_banks, :identifier, :name
  end
end
