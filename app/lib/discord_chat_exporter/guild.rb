require 'open3'

module DiscordChatExporter
  class Guild
    # TODO: キーワード引数の方が分かりやすいかも
    def initialize(server_id=nil, token=nil, app_dll_path=nil)
      @server_id = server_id || ENV['SERVER_ID']
      @token = token || ENV['TOKEN']
      @app_dll_path = app_dll_path || ENV['APP_DLL_PATH']
    end

    # DM を含む
    def list
      command = "`(which dotnet)` #{@app_dll_path} guilds --token #{@token}"

      stdout, stderr, _status = Open3.capture3(command)
      raise if stderr&.lines.present? && stderr.lines[0].start_with?('ERROR:')

      File.open("tmp/DiscordChatExporter_Guild_list_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.txt", 'w') { |f| f.puts(stdout) }

      stdout
    rescue StandardError => e
      Rails.logger.warn 'エラーです: DiscordChatExporter::Guild#list'
      Rails.logger.warn stderr.lines[0] unless stderr.nil?
      Rails.logger.warn e if e.present?

      bugsnag_error_message = "エラーです: DiscordChatExporter::Guild#list || stderr: #{stderr.lines[0] unless stderr.nil?} || StandardError: #{e}"
      Bugsnag.notify(bugsnag_error_message)
    end
  end
end
