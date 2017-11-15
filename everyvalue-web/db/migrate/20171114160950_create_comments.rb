class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :subject
      t.integer :parent_id
      t.references :user
      t.string :user_nickname
      t.integer :user_value
      t.text :contents

      t.timestamps
    end

    add_index :comments, :parent_id
  end
end
