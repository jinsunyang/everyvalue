class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :subject
      t.references :user
      t.string :user_nickname
      t.text :contents

      t.timestamps
    end
  end
end
