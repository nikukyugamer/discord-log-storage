# Discord Log Storage
- [Discord](https://discord.com/) のログを収集するアプリケーションです
- `$ bin/rails runner` 経由でログを取得し、データベースに格納します
- ログ収集の外部プログラムとして [DiscordChatExporter](https://github.com/Tyrrrz/DiscordChatExporter) を用います

## Tech Stack
- ActiveRecord (Ruby on Rails)
- [Tyrrrz/DiscordChatExporter: Exports Discord chat logs to a file](https://github.com/Tyrrrz/DiscordChatExporter)
