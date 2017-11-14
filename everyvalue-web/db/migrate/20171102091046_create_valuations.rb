class CreateValuations < ActiveRecord::Migration[5.1]
  def change
    create_table :valuations do |t|
      t.references :subject
      t.references :user
      t.string :user_nickname
      t.integer :price

      t.timestamps
    end
  end
end
