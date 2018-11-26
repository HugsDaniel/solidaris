class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.string :kind
      t.integer :total_volunteers
      t.integer :siren
      t.string :category
      t.string :website
      t.string :facebook
      t.string :linkedin
      t.string :twitter
      t.string :address
      t.date :creation_date
      t.references :manager, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
