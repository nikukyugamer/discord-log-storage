class Importer
  class  << self
    def guild_list(guild_list_response, upsert: false)
      guild_list_response.each_line do |guild_data|
        split_guild_data = guild_data.match(/(.*?)( \| )(.*)/)

        guild_id_number = split_guild_data[1]
        guild_name = split_guild_data[3].chomp
        guild = Guild.find_by(id_number: guild_id_number)

        if !upsert || (upsert && guild.blank?)
          guild = Guild.new(
            id_number: guild_id_number,
            name: guild_name
          )

          guild.save!
        else
          guild.update!(
            id_number: guild_id_number,
            name: guild_name
          )
        end
      end
    rescue StandardError => e
      Rails.logger.fatal 'Importer: #guild_list でエラーが発生しました'
      Rails.logger.fatal e
    end

    def channel_list(channel_list_response, upsert: false)
      channel_list_response.each_line do |channel_data|
        split_channel_data = channel_data.match(/(.*?)( \| )(.*)/)

        channel_id_number = split_channel_data[1]
        channel_name = split_channel_data[3].chomp
        channel = Channel.find_by(id_number: channel_id_number)

        if !upsert || (upsert && channel.blank?)
          channel = Channel.new(
            id_number: channel_id_number,
            name: channel_name
          )

          channel.save!
        else
          channel.update!(
            id_number: channel_id_number,
            name: channel_name
          )
        end
      end
    rescue StandardError => e
      Rails.logger.fatal 'Importer: #channel_list でエラーが発生しました'
      Rails.logger.fatal e
    end

    def convert_response_key_to_columen_name(response_key)
      {
        'id' => 'id_number',
        'isBot' => 'is_bot',
        'avatarUrl' => 'avatar_url',
        'iconUrl' => 'icon_url',
        'isAnimated' => 'is_animater',
        'imageUrl' => 'image_url'
      }.fetch(response_key, response_key)
    end
  end
end
