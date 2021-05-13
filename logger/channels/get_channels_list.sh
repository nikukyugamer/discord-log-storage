#!/bin/sh

CURRENT_DATETIME=$(date '+%Y%m%d_%H%M%S')

${DOTNET_PATH} ${DISCORD_CHAT_EXPORTER_DLL_PATH} channels --guild ${DISCORD_SERVER_ID} --token ${DISCORD_TOKEN} > log/eiyuden_discord_channels_${CURRENT_DATETIME}.txt

$(which ruby) ./to_csv.rb ${CURRENT_DATETIME}

exit 0
