module DiscordChatExporter
  class DirectMessages
    def initialize
      @server_id = ENV['SERVER_ID']
      @token = ENV['TOKEN']
      @app_dll_path = ENV['APP_DLL_PATH']
    end

    def base_command(command_arg)
      "`(which dotnet)` #{@app_dll_path} #{command_arg} --token #{@token}"
    end

    def list
      command = base_command('dm')

      `#{command}`
    end

    def export(**options)
      command_arg = 'exportdm'
      command = build_command(command_arg, options)

      puts command
      # `#{command}`
    end

    private

    def build_command(command_arg, options)
      built_options = default_options.merge(options)

      output_path_option_str = "-o #{built_options[:output_path]} " if built_options[:output_path]
      format_option_str = "-f #{built_options[:format]} " if built_options[:format]
      after_option_str = "--after #{built_options[:after]} " if built_options[:after]
      before_option_str = "--before #{built_options[:before]} " if built_options[:before]
      partition_option_str = "-p #{built_options[:split_number]} " if built_options[:split_number]
      media_option_str = "--media " if built_options[:media]
      resume_media_option_str = "--reuse-media #{built_options[:resume_media]} " if built_options[:resume_media]
      date_format_option_str = "--dateformat #{built_options[:dateformat]} " if built_options[:dateformat]

      # puts "abc#{nil}def" #=> abcdef
      "`(which dotnet)` #{@app_dll_path} #{command_arg} --token #{@token} #{output_path_option_str}#{format_option_str}#{after_option_str}#{before_option_str}#{partition_option_str}#{media_option_str}#{resume_media_option_str}#{date_format_option_str}".chomp
      # `(which dotnet)` /opt/DiscordChatExporter/DiscordChatExporter.Cli.dll exportdm --token mfa.6S2aer2luBAqHwReRu-3VllgfeIIR8BIqugp2993YO5B143SbYOrrVreZDjQkoAa2ph534MzEv7PLg1XxrLV -f Json --after 2021/05/17 --before 2021/05/17
    end

    # def set_options(options)
    #   built_options = default_options.merge(options)

    #   output_path_option_str = "-o #{build_options[:output_path]}" if build_options[:output_path]
    #   format_option_str = "-f #{build_options[:format]}"
    #   after_option_str = "--after #{built_options[:after]}"
    #   before_option_str = "--before #{built_options[:before]}"
    #   partition_option_str = "-p #{built_options[:split_number]}"
    #   media_option_str = "--media" if built_options[:media]
    #   resume_media_option_str = "--reuse-media #{built_options[:resume_media]}"
    #   date_format_option_str = "--dateformat #{built_options[:dateformat]}"
    # end

    def default_options
      # TODO: after と before のタイムゾーンは？
      {
        output_path: nil,
        format: 'Json',
        after: Time.zone.now.strftime('%Y/%m/%d HH:mm'),
        before: Time.zone.now.strftime('%Y/%m/%d HH:mm'),
        split_number: nil,
        media: false,
        resume_media: false,
        deteformat: 'yyyy/MM/dd HH:mm',
      }
    end
  end
end

# bundle exec rails runner app/lib/discord_chat_exporter/direct_messages.rb
DiscordChatExporter::DirectMessages.new.export

# exportdm のオプション
# --parallel	Limits how many channels can be exported in parallel. Try to keep this number low so that your account doesn't get flagged. Default: 1
# -o	Output file or directory path
# -f	Output file format. Default: HtmlDark
# --after	Only include messages sent after this date
# --before	Only include messages sent before this date
# -p	Split output into partitions, each limited to this number of messages (e.g. 100) or file size (e.g. 10mb)
# --media	Download referenced media content
# --reuse-media	Reuse already existing media content to skip redundant downloads. Default: false.
# --dateformat	Date format used in output
