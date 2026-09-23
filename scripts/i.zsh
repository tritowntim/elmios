#!/bin/zsh

SIMULATOR_NAME="iPhone 17 Pro"

UDID=$(xcrun simctl list devices available |
  sed -nE "/${SIMULATOR_NAME} \(/{
    s/.*\(([0-9A-F-]{36})\).*/\1/p
    q
  }")

if [[ -z "$UDID" ]]; then
  echo "No $SIMULATOR_NAME simulator found."
  exit 1
fi

echo "Using $SIMULATOR_NAME: $UDID"

npx cap run ios --target "$UDID" "$@" --live-reload
