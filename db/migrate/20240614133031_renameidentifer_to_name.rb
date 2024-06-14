class RenameidentiferToName < ActiveRecord::Migration[7.1]
  def up
    rename_column :power_banks, :identifier, :name
  end

  def down
    rename_column :power_banks, :name, :identifier
  end
end
