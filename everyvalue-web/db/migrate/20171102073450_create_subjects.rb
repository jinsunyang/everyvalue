class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :title, null: false
      t.text :contents
      t.references :user
      t.string :user_nickname
      t.integer :average_value

      t.timestamps
    end

    add_index :subjects, :user_nickname
  end
end
