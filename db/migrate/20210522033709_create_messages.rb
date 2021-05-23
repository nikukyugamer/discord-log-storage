class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.bigint :id_number
      t.string :type_name # , null: false, default: '_TYPE_NAME_IS_NOTHING_'
      t.datetime :timestamp
      t.datetime :timestamp_edited
      t.datetime :call_ended_timestamp
      t.boolean :is_pinned # , null: false, default: false
      t.string :content # , null: false, default: '_CONTENT_IS_NOTHING_'
      t.jsonb :reference

      t.references :user
      t.references :channel

      t.timestamps
    end

    add_index :messages, :id_number, unique: true
  end
end
