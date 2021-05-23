class SetNotNullToSomeColumns < ActiveRecord::Migration[6.1]
  def change
    # Boolean の部分は NULL を許すか (true) 許さないか (false) が入る
    change_column_null :guilds, :id_number, false
    change_column_null :guilds, :name, false

    change_column_null :channels, :id_number, false
    change_column_null :channels, :name, false

    change_column_null :messages, :id_number, false
    change_column_null :messages, :type_name, false
    change_column_null :messages, :content, false

    change_column_null :attachments, :id_number, false

    change_column_null :reactions, :count, false

    change_column_null :users, :id_number, false
    change_column_null :users, :name, false
    change_column_null :users, :is_bot, false
  end
end
