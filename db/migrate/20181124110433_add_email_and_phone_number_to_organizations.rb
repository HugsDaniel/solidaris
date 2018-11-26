class AddEmailAndPhoneNumberToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :email, :string
    add_column :organizations, :phone_numer, :string
  end
end
