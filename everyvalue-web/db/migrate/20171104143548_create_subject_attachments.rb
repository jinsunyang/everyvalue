class CreateSubjectAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_attachments do |t|
      t.references :subject
      t.string :content

      t.timestamps
    end
  end
end
