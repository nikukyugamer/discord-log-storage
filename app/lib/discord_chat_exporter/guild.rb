module DiscordChatExporter
  class Guild
    def initialize(server_id=nil, token=nil, app_dll_path=nil)
      @server_id = server_id || ENV['SERVER_ID']
      @token = token || ENV['TOKEN']
      @app_dll_path = app_dll_path || ENV['APP_DLL_PATH']
    end

    # DM を含む
    def list
      command = "`(which dotnet)` #{@app_dll_path} guilds --token #{@token}"

      `#{command}`
    end
  end
end
