class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :phone
      t.integer :gender, limit: 1
      t.date :birth_date
      t.string :identity_provider
      t.boolean :is_authorized

      t.timestamps
    end
  end
end
