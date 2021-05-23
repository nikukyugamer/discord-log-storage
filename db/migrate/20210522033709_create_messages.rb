class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.bigint :id_number, null: false
      t.string :type_name, null: false, default: '_TYPE_NAME_IS_NOTHING_'
      t.datetime :timestamp, null: false, default: Time.zone.parse('1980/01/01 12:00:00')
      t.datetime :timestamp_edited, null: false, default: Time.zone.parse('1980/01/01 12:00:00')
      t.datetime :call_ended_timestamp, null: false, default: Time.zone.parse('1980/01/01 12:00:00')
      t.boolean :is_pinned, null: false, default: false
      t.string :content, null: false, default: '_CONTENT_IS_NOTHING_'

      t.references :user # STI: has_one :author, has_many :mentions
      t.references :channel

      t.timestamps
    end

    add_index :messages, :id_number, unique: true
  end
end
