#!/bin/bash

CURRENT_DATETIME=$(date '+%Y%m%d_%H%M%S')
# AFTER_DATETIME
# BEFORE_DATETIME
# CHANNEL_ID(S)
# FORMATS=['HtmlDark','PlainText','Json','Csv']

${DOTNET_PATH} ${DISCORD_CHAT_EXPORTER_DLL_PATH} export -c ${DISCORD_CHANNEL_ID} --token ${DISCORD_TOKEN} -f Json --dateformat "yyyy-MM-dd HH:mm:ss (JST)" --after "2021-01-14 05:00:00 +0900" --before "2021-02-15 05:00:00 +0900" --media -o myserver

# --media -o AFTER_DATETIME_BEFORE_DATETIME_FORMAT

exit 0

# You can change the export format to HtmlDark, HtmlLight, PlainText Json or Csv with -f format. The default format is HtmlDark.
