class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.bigint :id_number, null: false
      t.string :type_name, null: false, default: '_TYPE_NAME_IS_NOTHING_'
      t.string :category, null: false, default: '_CATEGORY_IS_NOTHING_'
      t.string :name, null: false, default: '_NAME_IS_NOTHING_'
      t.string :topic, null: false, default: '_TOPIC_IS_NOTHING_'

      t.references :guild

      t.timestamps
    end

    add_index :channels, :id_number, unique: true
  end
end
