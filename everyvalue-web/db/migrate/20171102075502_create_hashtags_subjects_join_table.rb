class CreateHashtagsSubjectsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :hashtags, :subjects do |t|
      t.index :hashtag_id
      t.index :subject_id
    end
  end
end
