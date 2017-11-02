class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.text :contents
      t.references :user, foreign_key: true
      t.string :user_nickname
      t.integer :average_value

      t.timestamps
    end
  end
end
