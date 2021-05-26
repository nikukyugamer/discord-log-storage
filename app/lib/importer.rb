class Importer
  class  << self
    def exported_data(exported_json, execute_update: false) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      ActiveRecord::Base.transaction do # rubocop:disable Metrics/BlockLength
        # Guild
        guild_params = exported_json['guild']
        guild_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
        guild_params_id_number = guild_params['id_number'].to_i

        searched_existing_guild_record = Guild.find_by(id_number: guild_params_id_number)
        if searched_existing_guild_record.present?
          searched_existing_guild_record.update!(guild_params)
        else
          Guild.new(guild_params).save!
        end
        existing_guild_record = Guild.find_by(id_number: guild_params_id_number)

        # Channel
        channel_params = exported_json['channel']
        channel_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
        channel_params_id_number = channel_params['id_number'].to_i

        searched_existing_channel_record = Channel.find_by(id_number: channel_params_id_number)
        if searched_existing_channel_record.present?
          searched_existing_channel_record.guild = existing_guild_record
          searched_existing_channel_record.update!(channel_params)
        else
          channel = Channel.new(channel_params)
          channel.guild = existing_guild_record
          channel.save!
        end
        existing_channel_record = Channel.find_by(id_number: channel_params_id_number)

        # Message と Message の子たち
        exported_json['messages'].each do |message_params| # rubocop:disable Metrics/BlockLength
          # 各テーブル用の値を取得
          author_params = message_params['author']
          author_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
          author_params_id_number = author_params['id_number'].to_i

          # 次で消してしまうので保存しておく
          all_attachments_params = message_params['attachments']
          all_embeds_params = message_params['embeds']
          all_reactions_params = message_params['reactions']
          all_mentions_params = message_params['mentions']

          # Message 保存時に余分な attributes（別モデルの attributes）を削除する
          message_params.delete('author')
          message_params.delete('attachments')
          message_params.delete('embeds')
          message_params.delete('reactions')
          message_params.delete('mentions')

          # User (Author)
          searched_existing_user_record = User.find_by(id_number: author_params_id_number)
          if searched_existing_user_record.present?
            searched_existing_user_record.update!(author_params) if execute_update
          else
            User.new(author_params).save!
          end
          existing_user_record = User.find_by(id_number: author_params_id_number)

          # Message
          message_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
          message_params_id_number = message_params['id_number'].to_i
          searched_existing_message_record = Message.find_by(id_number: message_params_id_number)

          if searched_existing_message_record.present?
            searched_existing_message_record.channel = existing_channel_record
            searched_existing_message_record.update!(message_params) if execute_update
          else
            message = Message.new(message_params)
            message.channel = existing_channel_record
            message.user = existing_user_record
            message.save!
          end
          existing_message_record = Message.find_by(id_number: message_params_id_number)

          # Attachment
          if all_attachments_params.present?
            all_attachments_params.each do |attachment_params|
              attachment_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
              attachment_params_id_number = attachment_params['id_number'].to_i
              searched_existing_attachment_record = Attachment.find_by(id_number: attachment_params_id_number)

              if searched_existing_attachment_record.present?
                searched_existing_attachment_record.message = existing_message_record
                searched_existing_attachment_record.update!(attachment_params) if execute_update
              else
                attachment = Attachment.new(attachment_params)
                attachment.message = existing_message_record
                attachment.save!
              end
            end
          end

          # Embed
          # レコードを一意に定めるカラムがないため、Update はしない（厳密には、アソシエーションをたどって判別はできる）
          if all_embeds_params.present?
            all_embeds_params.each do |embed_params|
              embed_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }

              embed = Embed.new(embed_params)
              embed.message = existing_message_record
              embed.save!
            end
          end

          # Reaction
          # レコードを一意に定めるカラムがないため、Update はしない（厳密には、アソシエーションをたどって判別はできる）
          if all_reactions_params.present?
            all_reactions_params.each do |reaction_params|
              reaction_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }

              reaction = Reaction.new(reaction_params)
              reaction.message = existing_message_record
              reaction.save!
            end
          end

          # User (Mention)
          if all_mentions_params.present?
            all_mentions_params.each do |mention_params|
              mention_params.transform_keys! { |key| convert_response_key_to_columen_name(key) }
              mention_params_id_number = mention_params['id_number'].to_i
              searched_existing_user_record = User.find_by(id_number: mention_params_id_number)

              if searched_existing_user_record.present?
                searched_existing_user_record.update!(mention_params) if execute_update
              else
                User.new(mention_params).save!
              end
            end
          end
        end
      end
    rescue StandardError => e
      Rails.logger.fatal 'エラーです: Importer#exported_data でエラーが発生しました'
      Rails.logger.fatal e

      Bugsnag.notify('エラーです: Importer#exported_data でエラーが発生しました')
      Bugsnag.notify(e)
    end

    def guild_list(guild_list_response)
      ActiveRecord::Base.transaction do
        return if guild_list_response.blank?

        guild_list_response.each_line do |guild_data|
          split_guild_data = guild_data.match(/(.*?)( \| )(.*)/)

          guild_id_number = split_guild_data[1]
          guild_name = split_guild_data[3].chomp
          guild = Guild.find_by(id_number: guild_id_number)

          if guild.present?
            guild.update!(id_number: guild_id_number, name: guild_name)
          else
            Guild.new(id_number: guild_id_number, name: guild_name).save!
          end
        end
      end
    rescue StandardError => e
      Rails.logger.fatal 'エラーです: Importer#guild_list でエラーが発生しました'
      Rails.logger.fatal e

      Bugsnag.notify('エラーです: Importer#guild_list でエラーが発生しました')
      Bugsnag.notify(e)
    end

    def channel_list(channel_list_response, guild_id_number: nil)
      ActiveRecord::Base.transaction do
        return if channel_list_response.blank?

        channel_list_response.each_line do |channel_data|
          split_channel_data = channel_data.match(/(.*?)( \| )(.*)/)

          channel_id_number = split_channel_data[1]
          channel_name = split_channel_data[3].chomp
          channel = Channel.find_by(id_number: channel_id_number)
          target_guild = Guild.find_by(id_number: guild_id_number)
          object_attributes = {
            id_number: channel_id_number,
            name: channel_name
          }

          object_attributes = object_attributes.merge({ guild: target_guild }) if target_guild.present?

          if channel.present?
            channel.update!(object_attributes)
          else
            Channel.new(object_attributes).save!
          end
        end
      end
    rescue StandardError => e
      Rails.logger.fatal 'エラーです: Importer#channel_list でエラーが発生しました'
      Rails.logger.fatal e

      Bugsnag.notify('エラーです: Importer#channel_list でエラーが発生しました')
      Bugsnag.notify(e)
    end

    def convert_response_key_to_columen_name(response_key)
      {
        'id' => 'id_number',
        'isBot' => 'is_bot',
        'avatarUrl' => 'avatar_url',
        'iconUrl' => 'icon_url',
        'isAnimated' => 'is_animater',
        'imageUrl' => 'image_url',
        'type' => 'type_name',
        'timestampEdited' => 'timestamp_edited',
        'callEndedTimestamp' => 'call_ended_timestamp',
        'isPinned' => 'is_pinned',
        'fileName' => 'file_name',
        'fileSizeBytes' => 'file_size_bytes'
      }.fetch(response_key, response_key)
    end
  end
end
