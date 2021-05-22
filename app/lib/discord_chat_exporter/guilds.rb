module DiscordChatExporter
  class Guilds
    def initialize
      @server_id = ENV['SERVER_ID']
      @token = ENV['TOKEN']
      @app_dll_path = ENV['APP_DLL_PATH']
    end

    def list
      command = "`(which dotnet)` #{@app_dll_path} guilds --token #{@token}"

      `#{command}`
    end
  end
end

# bundle exec rails runner app/lib/discord_chat_exporter/guilds.rb
puts DiscordChatExporter::Guilds.new.list

# iconUrl（アイコン画像）は export 経由でないと取得できない
# "guild": {
#   "id": "727952189024108645",
#   "name": "Eiyuden Chronicle",
#   "iconUrl": "Eiyuden Chronicle - general - pets [762352695066755112].json_Files/3cf0fe5b3c95b3ffbc4d31b950d01b7f-D1EE4.png"
# },
