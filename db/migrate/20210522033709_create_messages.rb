class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.bigint :id_number
      t.string :type_name
      t.datetime :timestamp
      t.datetime :timestamp_edited
      t.datetime :call_end_timestamp
      t.boolean :is_pinned
      t.string :content

      t.references :user # STI: has_one :author, has_many :mentions
      t.references :channel

      t.timestamps
    end

    add_index :messages, :id_number, unique: true
  end
end
