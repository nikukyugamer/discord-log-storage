module DiscordChatExporter
  class Channels
    def initialize
      @server_id = ENV['SERVER_ID']
      @token = ENV['TOKEN']
      @app_dll_path = ENV['APP_DLL_PATH']
    end

    def list(*_options)
      # command = "`(which dotnet)` #{@app_dll_path} channels --guild #{@server_id} --token #{@token}"
      # command = "`(which dotnet)` #{@app_dll_path} guilds --token #{@token} -f Json"
      command = "`(which dotnet)` #{@app_dll_path} export -c 830755461086707775 --token #{@token} -f HtmlDark --media --dateformat "yyyy/MM/dd HH:mm""

      `#{command}`
    end

    # This command exports all channels of a Server.
    def export_all_channels_in_a_specific_server
      # exportguild: --token and --guild
    end

    # This command exports all accessible channels, including server channels and DMs.
    def export_all_channels_in_all_guilds
      # exportall: --token
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

    def basic_info
      # チャンネル情報は message 経由でないと取得できないので、「今日から今日まで」という最短の期間で message を取得する
      # message の取得は目的ではないので、最小限にする
    end

    def format_channel_list # (channel_list)
      channel_list = <<~CHANNEL_LIST
        738178139544354827 | ~💕Staff💕~ / admin-bot
        727952189439344784 | ~💕Staff💕~ / admin-chat
        727952189439344788 | ~💕Staff💕~ / chat-flags
        777606365060792351 | ~💕Staff💕~ / jp-staff-chat
        727952189439344781 | ~💕Staff💕~ / lounge-chat
        749242195072254003 | ~💕Staff💕~ / mod-tldr
        817883370515071050 | ~💕Staff💕~ / new-rules
        727952189439344789 | ~💕Staff💕~ / ping-flags
        727952189439344790 | ~💕Staff💕~ / reddit-mods
        810266475360550951 | ~💕Staff💕~ / social-media-posts
        727952189439344782 | ~💕Staff💕~ / staff-chat
        727952189439344787 | ~💕Staff💕~ / staff-commands
        810218834102845460 | ~💕Staff💕~ / staff-meeting
        727952189439344785 | ~💕Staff💕~ / staff-tldr
        727952189741596797 | ~💕Staff💕~ / staff-voting
        727952189439344783 | ~💕Staff💕~ / trial-mod-discussion
        817881022892736554 | ~💕Staff💕~ / zepp-flags
        727952189741596799 | Administrative Channels / ban-appeals
        727952189955244143 | Logs / censor-logs
        727952189955244145 | Logs / join-leave-logs
        727952189741596802 | Logs / message-logs
        727952189955244146 | Logs / moderation-logs
        727952189955244144 | Logs / nick-name-logs
        727952189955244148 | Logs / vc-logs
        740989475462840380 | Eiyuden Community Team / ambassador-chat
        740978582918135929 | Eiyuden Community Team / art-chat
        740975482484293664 | Eiyuden Community Team / developer-chat
        740975404864634990 | Eiyuden Community Team / ect-chat
        727952190425006173 | Eiyuden Community Team / event-chat
        740978502752534630 | Eiyuden Community Team / lore-chat
        727952191054282784 | Eiyuden Community Team / submission-logs
        740975742057316442 | Eiyuden Community Team / translator-chat
        727952191054282783 | Eiyuden Community Team / voting-publish
        740978054196756502 | Eiyuden Community Team / writing-chat
        727962346361716910 | Information / beta-registration
        727952191503204385 | Information / education
        737920534263627776 | Information / eiyuden-faq
        727952191054282788 | Information / how-to-report
        727952191054282787 | Information / information
        737367681384185993 | Information / intro
        727962464414728262 | Information / kickstarter-details
        727952191503204383 | Information / roles
        727952191054282786 | Information / rules
        727952191503204386 | Information / server-partners
        727952191054282789 | Information / staff-bios
        727963056126165100 | Announcements / eiyuden-announcements
        738160966180798534 | Announcements / eiyuden-content
        727963089311629444 | Announcements / server-announcements
        727952191930761278 | Community / ama
        727952191503204390 | Community / community-calendar
        727952191503204389 | Community / community-portal
        727952191503204392 | Community / influencer-chat
        747503135643140237 | Community / poll-chat
        727952191503204391 | Community / polls
        727952191930761283 | Activities / activities-announcement
        727963655450132530 | Activities / activities-chat
        727952191930761281 | Activities / activities-info
        727952191930761285 | Activities / activities-submission
        727952191930761284 | Activities / activities-voting
        727952192350322708 | Activities / alliance-trivia
        727952191930761287 | Activities / trivia
        727952192350322712 | Eiyuden Chronicle / eiyuden-chronicle-chat
        727952192350322713 | Eiyuden Chronicle / eiyuden-chronicle-ps
        727952192350322716 | Eiyuden Chronicle / eiyuden-chronicle-switch
        727952192350322714 | Eiyuden Chronicle / eiyuden-chronicle-xbox
        762352201468477451 | Eiyuden Chronicle / eiyuden-fan-media
        727952192769622130 | Eiyuden Chronicle / kickstarter-questions
        816283553275838474 | general / anime-and-manga
        727952193142915123 | general / bot-commands
        727952192769622133 | general / general-chat
        737676707619799091 | general / general-games-chat
        762352715635359745 | general / hobbies
        727952192769622135 | general / multimedia
        762352695066755112 | general / pets
        746233451128029205 | 日本語 / amaチャット
        741373897319907467 | 日本語 / ゲーム全般
        741486931942178856 | 日本語 / ルール
        737196589206077451 | 日本語 / 雑談
        741373780903067709 | 日本語 / 百英雄伝
        727952193142915126 | 🎤 Voice Channels 🎤 / music-bot
        727952193142915125 | 🎤 Voice Channels 🎤 / vc-text-chat
        756559582951899276 | Archive / staff-meeting-archive
      CHANNEL_LIST

      result = []
      channel_list.each_line { |line| result << line }

      result.each do |channel|
        split_strings = channel.split(/( \| )/)
        channel_id, channel_name = split_strings[0], split_strings[2]

        puts "#{channel_id}"
        puts "#{channel_name}"
        puts '-----------------'
        # puts channel
      end

      # result
    end
  end
end

puts DiscordChatExporter::Channels.new.list({hoge: 'fuga'})
# p DiscordChatExporter::Channels.new.format_channel_list
# p DiscordChatExporter::Channels.new.format_channel_list.class
# p DiscordChatExporter::Channels.new.format_channel_list.count
# DiscordChatExporter::Channels.new.format_channel_list
