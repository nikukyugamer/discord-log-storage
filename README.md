# Discord Log Storage
- [Discord](https://discord.com/) のログを収集するアプリケーションです
- `$ bin/rails runner` 経由でログを取得し、データベースに格納します
- ログ収集の外部プログラムとして [DiscordChatExporter](https://github.com/Tyrrrz/DiscordChatExporter) を用います

## Tech Stack
- ActiveRecord (Ruby on Rails)
- [Tyrrrz/DiscordChatExporter: Exports Discord chat logs to a file](https://github.com/Tyrrrz/DiscordChatExporter)

## 実行例
- 0. [DiscordChatExporter](https://github.com/Tyrrrz/DiscordChatExporter) をインストール
- 1. リポジトリを clone して `$ bundle install`
- 2. `.env.sample` を `.env` という名前でコピーし、各種の値を設定する
- 3. `$ bin/rails db:create && bin/rails db:migrate` を実行してデータベースを作成する
  - 現状、PostgreSQL を使うことを前提としている
- 4. 実行したいコマンドを `$ bin/rails runner` 経由で実行する（この段階ではデータベースには保存されない）
  - `$ bin/rails runner DiscordChatExporter::Guild.new.list` など
    - 結果を表示させたい場合は `puts` すると良い ( `$ bin/rails runner 'puts DiscordChatExporter::Guild.new.list'` )
- 5. データベースに保存するためには `Importer` クラスを用いる
  - TODO: 詳細を書く

## DiscordChatExporter::Channel.new.export

### オプションとそのサンプル値一覧
`app/lib/discord_chat_exporter/channel.rb#export` および [公式ドキュメント](https://github.com/Tyrrrz/DiscordChatExporter/wiki/GUI%2C-CLI-and-Formats-explained#dcecli-commands) より。

- channel_id
  - 必須
  - `1234567890`
- date_format
  - `'yyyy-MM-dd HH:mm:ss.ffff'`
- output_directory
  - ファイル名まで指定することも可能
  - ディレクトリが存在しない場合は自動作成される
- begin_datetime
  - JST
  - Time.zone.yesterday
- end_datetime
  - JST
  - Time.zone.today
- download_media
  - `true`
- reuse_media
  - `true`
- output_format
  - `Json`
