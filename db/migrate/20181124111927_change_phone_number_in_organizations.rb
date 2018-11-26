class ChangePhoneNumberInOrganizations < ActiveRecord::Migration[5.2]
  def change
    rename_column :organizations, :phone_numer, :phone_number
  end
end
