class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.references :comment
      t.references :subject
      t.references :user
      t.string :user_nickname
      t.text :contents

      t.timestamps
    end
  end
end
