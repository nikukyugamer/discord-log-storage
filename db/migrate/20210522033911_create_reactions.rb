class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.integer :count
      t.jsonb :emoji

      t.references :message

      t.timestamps
    end
  end
end
