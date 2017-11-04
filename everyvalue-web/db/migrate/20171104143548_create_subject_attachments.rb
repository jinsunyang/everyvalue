class CreateSubjectAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_attachments do |t|
      t.references :subject, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
