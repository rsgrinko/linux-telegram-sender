#!/bin/bash

# Данный скрипт пренданзачен для отправки stdin потока в Telegram
#
# Для его настройки замените API_TOKEN на токен бота
# Также измените CHAT_ID на идентификатор пользователя (чата), куда будут отправляться сообщения
# Дайте скрипту права на выполнение chmod +x telegram.sh
# Для удобства можно закинуть его или симлинк на него в /bin/telegram
# cp telegram.sh /bin/telegram
# Для проверки используйте команду echo test | telegram
# Или передайте строку аргументом telegram "Hello World!"
# Если все настроено правильно - вам придет сообщение
#
# Author: rsgrinko <rsgrinko@gmail.com>
# Site: is-stories.ru
# Github: https://github.com/rsgrinko

API_TOKEN="insert_here_your_bot_token_please"
CHAT_ID="insert_here_your_chat_id_please"

trap 'shutdown' SIGINT

sendMessage() {
    curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$TG_MESSAGE" -d parse_mode=html >> /dev/null
}

shutdown(){
    TG_MESSAGE="↓ Warning! Process completed incorrectly  ↓"
    sendMessage
}

MESSAGE=$1
if [ -z "$MESSAGE" ]
then
    MESSAGE=`cat /dev/stdin`
fi

TG_MESSAGE="<b><u>Message from $(hostname)</u></b>
<b>Date: $(date  "+%d.%m.%Y %H:%M:%S")</b>
$MESSAGE"

sendMessage
