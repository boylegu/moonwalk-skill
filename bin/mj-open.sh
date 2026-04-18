#!/usr/bin/env bash

provider="${MJ_PROVIDER:-auto}"
script_dir="$(cd "$(dirname "$0")" && pwd)"
platform="$(uname -s 2>/dev/null || printf 'unknown')"

if [[ "${1:-}" == "--provider" ]]; then
  provider="${2:-}"
  shift 2
fi

query="$*"

if [[ -z "$query" ]]; then
  echo "Usage: mj-open [--provider auto|youtube|ytmusic|spotify|apple|qq|netease] <song name>"
  exit 1
fi

encoded_query=$(printf '%s' "Michael Jackson $query" | sed 's/ /+/g')
spotify_uri_query=$(printf '%s' "Michael Jackson $query" | sed 's/ /%20/g')

contains_cjk() {
  printf '%s' "$1" | LC_ALL=C.UTF-8 grep -q '[一-龥ぁ-んァ-ヶ]'
}

resolve_auto_provider() {
  if contains_cjk "$query"; then
    printf '%s' "qq"
  elif [[ "$platform" == "Darwin" ]]; then
    printf '%s' "apple"
  else
    printf '%s' "spotify"
  fi
}

if [[ -z "$provider" || "$provider" == "auto" ]]; then
  provider="$(resolve_auto_provider)"
fi

case "$provider" in
  youtube|yt)
    url="https://www.youtube.com/results?search_query=$encoded_query"
    ;;
  ytmusic|youtube-music)
    url="https://music.youtube.com/search?q=$encoded_query"
    ;;
  spotify)
    url="https://open.spotify.com/search/$encoded_query"
    ;;
  apple|apple-music)
    url="https://music.apple.com/us/search?term=$encoded_query"
    ;;
  qq|qqmusic)
    url="https://y.qq.com/n/ryqq/search?w=$encoded_query"
    ;;
  netease|163)
    url="https://music.163.com/#/search/m/?s=$encoded_query&type=1"
    ;;
  *)
    echo "Unsupported provider: $provider"
    echo "Supported providers: auto, youtube, ytmusic, spotify, apple, qq, netease"
    exit 1
    ;;
esac

echo "Provider: $provider"
echo "Opening: $url"

write_state() {
  if [[ -x "$script_dir/mj-state-write" ]]; then
    "$script_dir/mj-state-write" open "$provider" "$query" "$query" "$url" >/dev/null 2>&1 || true
  fi
}

open_url() {
  "$@" "$url"
}

open_spotify_client() {
  if command -v open >/dev/null 2>&1; then
    open "spotify:search:$spotify_uri_query"
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "spotify:search:$spotify_uri_query"
  else
    return 1
  fi
}

open_apple_music_client() {
  if command -v open >/dev/null 2>&1; then
    open -a Music "$url"
  else
    return 1
  fi
}

open_in_browser() {
  # macOS
  if command -v open >/dev/null 2>&1; then
    open_url open || return 1
  # Linux
  elif command -v xdg-open >/dev/null 2>&1; then
    open_url xdg-open || return 1
  # Windows (Git Bash / WSL)
  elif command -v start >/dev/null 2>&1; then
    open_url start || return 1
  else
    return 1
  fi
}

# Only Spotify and Apple Music attempt native desktop app launch.
# Other providers use web search directly for more predictable behavior.
case "$provider" in
  spotify)
    write_state
    open_spotify_client || open_in_browser || echo "Please open manually: $url"
    ;;
  apple|apple-music)
    write_state
    open_apple_music_client || open_in_browser || echo "Please open manually: $url"
    ;;
  *)
    write_state
    open_in_browser || echo "Please open manually: $url"
    ;;
esac
