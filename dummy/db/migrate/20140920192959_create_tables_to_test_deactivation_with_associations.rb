class CreateTablesToTestDeactivationWithAssociations < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true
      t.string :text

      t.timestamps
    end
    create_table :some_credential_data do |t|
      t.references :credential, index: true
      t.string :text

      t.timestamps
    end
  end
end
