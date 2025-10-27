#!/bin/bash

# Telegram Notification Script
# Usage: ./send_telegram.sh "message" [emoji]
# Example: ./send_telegram.sh "Task completed" "✅"

# Check if required environment variables are set
if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
    echo "⚠️ Telegram notification skipped: Set TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID environment variables"
    exit 1
fi

# Get message from first argument
MESSAGE="${1:-No message provided}"

# Get optional emoji from second argument (default to 🤖)
EMOJI="${2:-🤖}"

# Add timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Format the complete message
FULL_MESSAGE="$EMOJI $MESSAGE at $TIMESTAMP"

# Send to Telegram
RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d "chat_id=$TELEGRAM_CHAT_ID" \
    -d "text=$FULL_MESSAGE" \
    -d "parse_mode=HTML")

# Check if sending was successful
if echo "$RESPONSE" | grep -q '"ok":true'; then
    echo "✓ Telegram notification sent successfully"
    exit 0
else
    echo "✗ Failed to send Telegram notification"
    echo "Response: $RESPONSE"
    exit 1
fi
