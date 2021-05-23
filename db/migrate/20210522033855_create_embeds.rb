class CreateEmbeds < ActiveRecord::Migration[6.1]
  def change
    create_table :embeds do |t|
      t.string :title, null: false, default: '_TITLE_IS_NOTHING_'
      t.string :url, null: false, default: '_URL_IS_NOTHING_'
      t.datetime :timestamp, null: false, default: Time.zone.parse('1980/01/01 12:00:00')
      t.string :description, null: false, default: '_DESCRIPTION_IS_NOTHING_'
      t.jsonb :thumbnail
      t.string :fields, null: false, default: '_FIELDS_IS_NOTHING_' # レスポンスは Array だが、レスポンス例が分からないのでとりあえず String 型で格納する

      t.references :message

      t.timestamps
    end
  end
end
