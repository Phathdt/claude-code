#!/bin/bash
# Telegram notification script for Claude Code hooks
# Reads credentials from ~/.env file

# Source environment variables from ~/.env
if [[ -f ~/.env ]]; then
    source ~/.env
fi

# Check if required variables are set
if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
    echo "Telegram notification skipped: TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID not set in ~/.env"
    exit 0
fi

# Get message type from argument (default: "finished")
MESSAGE_TYPE="${1:-finished}"

case "$MESSAGE_TYPE" in
    "stop")
        MESSAGE="Claude Code finished working at $(date '+%Y-%m-%d %H:%M:%S')"
        ;;
    "subagent")
        MESSAGE="Claude Code subagent completed task at $(date '+%Y-%m-%d %H:%M:%S')"
        ;;
    *)
        MESSAGE="Claude Code: $MESSAGE_TYPE at $(date '+%Y-%m-%d %H:%M:%S')"
        ;;
esac

# Send notification
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d "chat_id=$TELEGRAM_CHAT_ID" \
    -d "text=$MESSAGE" \
    -d "parse_mode=HTML" >/dev/null 2>&1

if [[ $? -eq 0 ]]; then
    exit 0
else
    echo "Failed to send Telegram notification"
    exit 1
fi
