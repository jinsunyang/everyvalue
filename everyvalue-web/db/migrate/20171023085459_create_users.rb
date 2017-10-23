class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname, null: false
      # t.string :phone, null: false
      t.integer :gender, limit: 1
      t.date :birth_date
      t.string :identity_provider, default: 'own'
      # t.boolean :is_authorized, default: false, null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :nickname, unique: true
    # add_index :users, :phone, unique: true
  end
end
