class DropOrganizations < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :missions, :organizations
    drop_table :organizations
  end
end
