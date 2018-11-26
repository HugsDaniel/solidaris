class ChangeCreationDateInOrganizations < ActiveRecord::Migration[5.2]
  def change
    rename_column :organizations, :creation_date, :creation_year
    change_column :organizations, :creation_year, :string
  end
end
