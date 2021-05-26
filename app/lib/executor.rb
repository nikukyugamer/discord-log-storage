class Executor
  class << self
    def save_channel_export_data_to_database(options)
      # データの取得オプションを定義し、
      file_name = "tmp/executor_output_temporary_for_saving_to_database_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.json"
      # TODO: なんか汚い
      options = options.merge({ output_directory: file_name }) if options[:output_directory].blank?

      # データを取得して一時ファイルに保存し、
      DiscordChatExporter::Channel.new.export(merged_options(options))
      return unless File.exist?(Rails.root.join(file_name))

      exported_json = JSON.parse(File.read(Rails.root.join(file_name)))

      # データベースにデータを格納して、
      Importer.exported_data(exported_json)

      # 一時ファイルを削除する。
      File.delete(Rails.root.join(file_name))
    rescue StandardError => e
      Rails.logger.fatal 'FATAL エラーです: Executor#only_save_channel_export_data_to_database'
      Rails.logger.fatal e if e.present?

      bugsnag_error_message = "FATAL エラーです: Executor#only_save_channel_export_data_to_database / #{e}"
      Bugsnag.notify(bugsnag_error_message)
    end

    def save_channel_export_data_to_files(options)
      files_directory = "tmp/#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}"
      # TODO: なんか汚い
      options = options.merge({ output_directory: files_directory }) if options[:output_directory].blank?

      DiscordChatExporter::Channel.new.export(merged_options(options))
    rescue StandardError => e
      Rails.logger.fatal 'FATAL エラーです: Executor#save_channel_export_data_to_files'
      Rails.logger.fatal e if e.present?
      Rails.logger.fatal options if e.present?

      bugsnag_error_message = "FATAL エラーです: Executor#save_channel_export_data_to_files / #{e} / #{options}"
      Bugsnag.notify(bugsnag_error_message)
    end

    def save_all_channels_data_in_all_guilds
      Importer.guild_list(DiscordChatExporter::Guild.new.list)

      Guild.all.each do |guild|
        Importer.channel_list(DiscordChatExporter::Channel.new(guild.id_number).list)
      end
    end

    def initial_collect_channel_data_to_database(start_date_to_collect, target_channel_id)
      target_begin_datetime = start_date_to_collect
      target_end_datetime = target_begin_datetime + 1.week

      until target_begin_datetime > Time.zone.today
        save_channel_export_data_to_database(
          {
            channel_id: target_channel_id,
            begin_datetime: target_begin_datetime,
            end_datetime: target_end_datetime
          }
        )

        target_begin_datetime += 1.week
        target_end_datetime = target_begin_datetime + 1.week
      end
    end

    def initial_collect_channel_html_dark_files(start_date_to_collect, target_channel_id)
      files_directory = "log/HtmlDark_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}"
      target_begin_datetime = start_date_to_collect
      target_end_datetime = target_begin_datetime + 1.week

      until target_begin_datetime > Time.zone.today
        save_channel_export_data_to_files(
          {
            output_directory: files_directory,
            channel_id: target_channel_id,
            begin_datetime: target_begin_datetime,
            end_datetime: target_end_datetime,
            output_format: 'HtmlDark',
            download_media: true
          }
        )

        target_begin_datetime += 1.week
        target_end_datetime = target_begin_datetime + 1.week
      end
    end

    def merged_options(options)
      default_options = {
        output_directory: "tmp/executor_output_temporary_for_saving_to_database.json",
        output_format: 'Json'
      }

      default_options.merge(options).slice(*permitted_option_keys)
    end

    # README を参照
    def permitted_option_keys
      %i(
        channel_id
        date_format
        output_directory
        begin_datetime
        end_datetime
        download_media
        reuse_media
        output_format
      )
    end
  end
end
