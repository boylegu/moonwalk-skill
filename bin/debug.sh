#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

cd "$repo_root"
export PATH="$repo_root/bin:$PATH"

echo "== Shell syntax checks =="
bash -n bin/mj-open.sh
bash -n bin/mj-open
bash -n bin/mj-recommend
bash -n bin/mj-state-write
bash -n bin/mj-status
bash -n bin/mj-watch

echo
echo "== JSON validation =="
if command -v python3 >/dev/null 2>&1; then
  python3 -m json.tool .claude-plugin/plugin.json >/dev/null
  python3 -m json.tool data/songs.json >/dev/null
elif command -v python >/dev/null 2>&1; then
  python -m json.tool .claude-plugin/plugin.json >/dev/null
  python -m json.tool data/songs.json >/dev/null
else
  echo "Skipping strict JSON validation: Python not found."
fi

echo
echo "== Sample recommendations =="
for context in "coding" "night" "party" "写代码" "晚上 放松"; do
  echo
  echo "-- mj-recommend \"$context\""
  mj-recommend "$context"
done

echo
echo "== Sample command runs =="
for song in "Billie Jean" "Human Nature" "Smooth Criminal"; do
  echo
  echo "-- mj-open \"$song\""
  mj-open "$song"
done

echo
echo "== HUD status =="
mj-status

echo
echo "Debug checks completed."
