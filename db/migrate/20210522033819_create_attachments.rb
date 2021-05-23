class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    # belongs_to :message
    create_table :attachments do |t|
      t.bigint :id_number, null: false
      t.string :url, null: false, default: '_URL_IS_NOTHING_'
      t.string :file_name, null: false, default: '_FILE_NAME_IS_NOTHING_'
      t.integer :file_size_bytes, null: false, default: 0

      t.references :message

      t.timestamps
    end

    add_index :attachments, :id_number, unique: true
    # add_foreign_key :attachments, :message, foreign_key: true
  end
end
