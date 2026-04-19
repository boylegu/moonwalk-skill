<div align="center">
<p align="center">
<img src="https://cdn.jsdelivr.net/gh/boylegu/moonwalk-skill/assets/mjskill.png?raw=true" width="300" height="300" alt="Moonwalk Skill preview">
</p>

<p>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="license" />
  <img src="https://img.shields.io/badge/platform-Claude%20Code-blue?style=for-the-badge" alt="platform" />
  <img src="https://img.shields.io/badge/type-plugin-orange?style=for-the-badge" alt="type" />
  <img src="https://img.shields.io/badge/status-active-success?style=for-the-badge" alt="status" />
</p>
</div>

# moonwalk-skill

English | [简体中文](./README.zh-CN.md)

Moonwalk Skill is a Claude Code plugin focused on Michael Jackson music. It reads simple mood cues, recommends fitting songs, and opens the selected track fast.

This project is an independent fan-made plugin. It is not affiliated with, endorsed by, or sponsored by the Michael Jackson Estate or any official rights holder.

## What It Does

- Recommends 2-4 songs based on mood, context, or activity
- Supports direct song requests such as `Billie Jean` and `Human Nature`
- Adds a short, restrained emotional line when you sound tired, low, stressed, or nostalgic
- Opens the selected song through a supported music provider
- Supports both natural-language use and direct `/moonwalk-skill:mj` invocation

## When You'd Use It

Use it when you want the right song without overthinking the request:

- You already know the song and want it opened quickly
- You want a few picks for coding, focus, late night, or winding down
- You want something softer after a rough day
- You want recommendations from a single, consistent catalog instead of doing general music search

Typical requests look like this:

```text
play Billie Jean
something for coding
something softer for late night
I had a rough day, play something gentle
/moonwalk-skill:mj Billie Jean
```

## How It Responds

Natural language is the default entry point.

1. If you name a song, it opens that song directly.
2. If you describe a mood, activity, or moment, it recommends 2-4 songs first.
3. If the tone sounds personal, it adds one short, restrained line before the recommendations.
4. If you say yes, it opens the top pick.

The plugin is intentionally narrow. It is for Michael Jackson music requests, not general music playback or artist discovery.

## Supported Providers

- `auto`
- `youtube`
- `ytmusic`
- `spotify`
- `apple`
- `qq`
- `netease`

Auto-routing rules:

- Chinese requests default to `qq`
- English requests default to `apple` on macOS
- English requests default to `spotify` on non-macOS platforms
- An explicitly requested provider always wins

Open behavior:

- `spotify` tries the local Spotify app first, then falls back to web search
- `apple` tries the Music app first, then falls back to web search
- `qq`, `netease`, `youtube`, and `ytmusic` open web search directly

## Behavior and Limits

- This project does not host or distribute any music
- This project is independent and not an official Michael Jackson product
- Playback redirects to external platforms such as Apple Music, Spotify, QQ Music, NetEase, or YouTube
- Actual open behavior depends on the local OS, browser, and installed music apps
- Some providers may open a search page instead of direct playback
- The plugin only handles Michael Jackson music requests

## Installation

For local development:

```bash
claude --plugin-dir .
```

Then reload plugins inside Claude Code:

```text
/reload-plugins
```

Use `/help` to confirm the skill is available as `/moonwalk-skill:mj`.

For marketplace installation from GitHub:

```text
/plugin marketplace add boylegu/moonwalk-skill
/plugin install moonwalk-skill@mj-music
```

If the marketplace catalog changes, refresh the marketplace entry:

```text
/plugin marketplace update mj-music
```

If the plugin itself releases a new version, update the installed plugin:

```text
/plugin update moonwalk-skill@mj-music
```

## Usage Modes

### Natural language

This is the default and recommended mode. Claude should auto-trigger the skill when your request is clearly about Michael Jackson music.

### Direct skill invocation

Use this mainly for debugging or forcing the skill to run:

```text
/moonwalk-skill:mj Billie Jean
/moonwalk-skill:mj coding
/moonwalk-skill:mj I had a rough day, give me some MJ
```

## Local Commands

Add `bin/` to `PATH` first:

```bash
export PATH="$PWD/bin:$PATH"
```

### `mj-recommend`

Return 2-4 MJ songs for a mood or context:

```bash
mj-recommend coding
mj-recommend "I had a rough day and feel tired"
```

### `mj-open`

Open a song with a provider:

```bash
mj-open "Billie Jean"
mj-open --provider auto "Billie Jean"
mj-open --provider spotify "Billie Jean"
```

### `mj-status`

Print the latest plugin status line:

```bash
mj-status
```

### `mj-watch`

Refresh the latest status in a loop:

```bash
mj-watch
```

### `debug.sh`

Run quick syntax, JSON, and sample-command checks:

```bash
bash ./bin/debug.sh
```

## Expanding the Song Library

If you want to add more songs, edit [`data/songs.json`](./data/songs.json).

Each entry should stay in this shape:

```json
{
  "title": "Song Title",
  "tags": ["coding", "night", "comfort"]
}
```

Keep the tags short and consistent with the existing vocabulary. Reusing current tags is better than inventing near-duplicates, because recommendations depend on those tag matches.

After updating the file, run:

```bash
python3 -m json.tool data/songs.json >/dev/null
bash ./bin/debug.sh
```

## Validation

Useful checks from the repository root:

```bash
bash -n bin/mj-open.sh
bash -n bin/mj-recommend
python3 -m json.tool .claude-plugin/plugin.json >/dev/null
python3 -m json.tool .claude-plugin/marketplace.json >/dev/null
python3 -m json.tool data/songs.json >/dev/null
bash ./bin/debug.sh
```

## License

MIT
