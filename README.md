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
- 4. 実行したいコマンドを `$ bin/rails runner` 経由で実行する
  - 例えば、 `$ bin/rails runner DiscordChatExporter::Guild.new.list` など
- 5. データベースに保存するためには `Importer` クラスを用いる
  - 詳細は別項目参照

### コマンド一覧（簡易版）

#### ファイルを取得する
- サーバ一覧
  - `$ bin/rails runner 'DiscordChatExporter::Guild.new.list'`
    - 自分が属するサーバ一覧を取得し、 `tmp/DiscordChatExporter_Guild_list_*.txt` に保存する
- 特定のサーバ（サーバIDが `518371205452005387` とする）のチャンネル一覧
  - `$ bin/rails runner 'DiscordChatExporter::Channel.new(518371205452005387).list'`
    - サーバIDが `518371205452005387` であるサーバのチャンネル一覧を取得し、 `tmp/DiscordChatExporter_Channel_list_*.txt` に保存する
- 特定のチャンネル（チャンネルIDが `639068129145913354` とする）の発言を `HtmlDark` 形式で保存する
  - `$ bin/rails runner 'Executor.save_channel_export_data_to_files({ channel_id: 639068129145913354, output_format: 'HtmlDark', download_media: true })'`
  - このコマンドでは後述のオプションが指定できる

#### データベースへ書き込む
- サーバ一覧
  - `$ bin/rails runner 'Importer.guild_list(DiscordChatExporter::Guild.new.list)'`
- 特定のサーバ（サーバIDが `518371205452005387` とする）のチャンネル一覧
  - `$ bin/rails runner 'Importer.channel_list(DiscordChatExporter::Channel.new(518371205452005387).list, guild_id_number: 518371205452005387)'`
- 特定のチャンネル（チャンネルIDが `639068129145913354` とする）の発言
  - `$ bin/rails runner 'Executor.save_channel_export_data_to_database({ channel_id: 639068129145913354 })'`
  - このコマンドでは後述のオプションが指定できる

## DiscordChatExporter::Channel.new.export に関するオプション

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
