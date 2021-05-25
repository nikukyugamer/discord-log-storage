require 'open3'

module DiscordChatExporter
  class Channel
    def initialize(server_id=nil, token=nil, app_dll_path=nil)
      @server_id = server_id || ENV['SERVER_ID']
      @token = token || ENV['TOKEN']
      @app_dll_path = app_dll_path || ENV['APP_DLL_PATH']
    end

    def list
      raise StandardError, 'server_id が指定されていません' if @server_id.blank?

      arg = 'channels'
      command = "`(which dotnet)` #{@app_dll_path} #{arg} --guild #{@server_id} --token #{@token}"

      stdout, stderr, _status = Open3.capture3(command)
      raise if stderr&.lines.present? && stderr.lines[0].start_with?('ERROR:')

      stdout
    rescue StandardError => e
      Rails.logger.warn 'エラーです: DiscordChatExporter::Channel#list'
      Rails.logger.warn stderr.lines[0] unless stderr.nil?
      Rails.logger.warn e if e.present?

      bugsnag_error_message = "エラーです: DiscordChatExporter::Channel#list || stderr: #{stderr.lines[0] unless stderr.nil?} || StandardError: #{e}"
      Bugsnag.notify(bugsnag_error_message)
    end

    def export(options) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      raise StandardError, 'channel_id が指定されていません' if options[:channel_id].blank?

      arg = 'export'
      channel_id = options[:channel_id]
      date_format = options[:date_format] || 'yyyy-MM-dd HH:mm:ss.ffff'
      # ファイル名まで指定することも可能 & ディレクトリが存在しない場合は自動作成
      output_directory = options[:output_directory] || 'log'
      # begin_datetime と end_datetime は JST
      begin_datetime = options[:begin_datetime] || (Time.zone.today - 1.week).beginning_of_day.strftime('%Y-%m-%d %H:%M:%S')
      end_datetime = options[:end_datetime]
      download_media = options[:download_media] || false
      reuse_media = options[:reuse_media] || false
      output_format = options[:output_format] || 'Json'

      channel_id_option = "--channel #{channel_id} " if channel_id.present?
      output_directory_option = "--output '#{output_directory}' " if output_directory.present?
      date_format_option = "--dateformat '#{date_format}' " if date_format.present?
      begin_datetime_option = "--after '#{begin_datetime}' " if begin_datetime.present?
      end_datetime_option = "--before '#{end_datetime}' " if end_datetime.present?
      media_option = '--media ' if download_media == true
      reuse_media_option = '--reuse_media ' if reuse_media == true
      output_format_option = "--format '#{output_format}' " unless output_format.nil?

      command = "`(which dotnet)` #{@app_dll_path} #{arg} --token '#{@token}' #{channel_id_option}#{date_format_option}#{begin_datetime_option}#{end_datetime_option}#{output_format_option}#{output_directory_option}#{media_option}#{reuse_media_option}".strip

      stdout, stderr, _status = Open3.capture3(command)
      raise if stderr&.lines.present? && stderr.lines[0].start_with?('ERROR:')

      stdout
    rescue StandardError => e
      Rails.logger.warn 'エラーです: DiscordChatExporter::Channel#export'
      Rails.logger.warn stderr.lines[0] unless stderr.nil?
      Rails.logger.warn e if e.present?

      bugsnag_error_message = "エラーです: DiscordChatExporter::Channel#export || stderr: #{stderr.lines[0] unless stderr.nil?} || StandardError: #{e}"
      Bugsnag.notify(bugsnag_error_message)
    end

    def exportdm
    end

    def exportguild
    end

    def exportall
    end

    def first_export(start_datetime, end_date_time)
      # start_datetime ～ end_date_time のデータを1日単位で割って取得
      # 「息継ぎ」をする
    end

    def export_by_day(target_date)
      # from (target_date - 1).beginning_of_day to target_date.end_of_day
    end

    def file_formats
      [
        'HtmlDark',
        'HtmlLight',
        'PlainText',
        'Json',
        'Csv',
      ]
    end
  end
end
