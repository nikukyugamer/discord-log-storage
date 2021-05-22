class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.string :Embed
      t.string :Reaction

      t.timestamps
    end
  end
end
