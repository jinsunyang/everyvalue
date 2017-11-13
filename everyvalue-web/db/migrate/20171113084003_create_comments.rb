class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.string :user_nickname
      t.text :contents

      t.timestamps
    end
  end
end
