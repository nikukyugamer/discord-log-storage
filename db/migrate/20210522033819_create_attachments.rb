class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    # belongs_to :message
    create_table :attachments do |t|
      t.integer :id_number
      t.string :url
      t.string :file_name
      t.integer :file_size_bytes

      t.references :message

      t.timestamps
    end

    add_index :attachments, :id_number, unique: true
    # add_foreign_key :attachments, :message, foreign_key: true
  end
end
