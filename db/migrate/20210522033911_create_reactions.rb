class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.integer :count, null: false, default: -1
      t.jsonb :emoji

      t.references :message

      t.timestamps
    end
  end
end
