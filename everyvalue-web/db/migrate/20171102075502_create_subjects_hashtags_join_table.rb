class CreateSubjectsHashtagsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :subjects, :hashtags do |t|
      t.index :subject_id
      t.index :hashtag_id
    end
  end
end
