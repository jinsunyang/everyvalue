class CreateValuations < ActiveRecord::Migration[5.1]
  def change
    create_table :valuations do |t|
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.string :user_nickname
      t.integer :price

      t.timestamps
    end
  end
end
