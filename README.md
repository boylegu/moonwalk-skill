<div align="center">
<p align="center">
<img src="https://cdn.jsdelivr.net/gh/boylegu/moonwalk-skill/assets/mjskill.png?raw=true" width="300" height="300">
</p>

  <p>
    <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="license" />
    <img src="https://img.shields.io/badge/platform-Claude%20Code-blue?style=for-the-badge" alt="platform" />
    <img src="https://img.shields.io/badge/type-skill-orange?style=for-the-badge" alt="type" />
    <img src="https://img.shields.io/badge/status-active-success?style=for-the-badge" alt="status" />
  </p>
</div>

## moonwalk-skill

A Claude Code plugin that recommends and opens Michael Jackson songs with light emotion-aware guidance.

It is not just a song launcher. The skill can read simple mood cues like tired, stressed, nostalgic, calm, coding, or late night, respond with a short fitting line, recommend a few MJ tracks, and then open the selected song on a music provider.

## What It Does

- Recognizes Michael Jackson listening requests in normal conversation
- Recommends 2-4 songs based on mood, activity, or emotional state
- Supports direct song requests such as `Billie Jean` or `Human Nature`
- Opens music with provider auto-routing or an explicitly requested platform
- Gives short, restrained emotional framing instead of acting like a generic player
- Includes local helper commands for recommendation, opening, and status debugging

## Main Experience

For normal users, the main entry point is natural language.

Examples:

```text
play Billie Jean
I want to listen to Billie Jean
我想听 Billie Jean
give me some MJ songs for coding
something chill from MJ
I had a rough day, give me some MJ
我今天有点烦，来点 MJ
```

Typical flow:

1. If the user names a song, the plugin opens that song directly.
2. If the user shares a mood or activity, the plugin recommends 2-4 songs first.
3. If the mood sounds personal, the plugin adds one short emotionally aware line before the recommendation.
4. If the user says yes, the plugin opens the top recommendation.

## Trigger Modes

The plugin supports two ways to run:

### 1. Natural language

This is the default and recommended mode. Claude should auto-trigger the skill when the request is clearly about Michael Jackson music.

### 2. Direct skill invocation

Use this mainly for debugging or forcing the skill to run:

```text
/moonwalk-skill:mj Billie Jean
/moonwalk-skill:mj coding
/moonwalk-skill:mj 我今天有点烦，来点 MJ
```

## Emotion and Recommendation Behavior

The recommendation layer supports both context and emotion.

Common request types:

- `coding`, `focus`, `写代码`, `专注`
- `night`, `relax`, `chill`, `晚上`, `放松`
- `tired`, `drained`, `累`, `疲惫`
- `sad`, `low`, `lonely`, `难过`, `低落`, `孤独`
- `stress`, `anxious`, `烦`, `焦虑`, `压力`
- `nostalgic`, `怀旧`, `回忆`
- `confidence`, `打起精神`, `自信`
- `romantic`, `love`, `恋爱`, `暧昧`
- `hope`, `healing`, `希望`, `治愈`

The skill keeps the response short on purpose:

- one brief line to match the mood when helpful
- 2-4 recommended songs
- a simple follow-up like `Want me to play the first one?`

## Provider Routing

Supported providers:

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

Desktop app behavior:

- `spotify` tries the local Spotify app first, then falls back to web search
- `apple` tries the Music app first, then falls back to web search
- `qq`, `netease`, `youtube`, and `ytmusic` open web search directly

Examples:

```text
我想听 Billie Jean
```

Defaults to QQ Music.

```text
I want to listen to Billie Jean
```

Defaults to Apple Music on macOS.

```text
Play Billie Jean on Spotify
```

Uses Spotify because the provider was explicitly requested.

## Local Commands

After adding `bin/` to `PATH`, the local helper commands are:

```bash
export PATH="$PWD/bin:$PATH"
```

### `mj-recommend`

Return 2-4 MJ songs for a mood or context:

```bash
mj-recommend coding
mj-recommend "I had a rough day and feel tired"
mj-recommend "想怀旧一点"
```

### `mj-open`

Open a song with a provider:

```bash
mj-open "Billie Jean"
mj-open --provider auto "Billie Jean"
mj-open --provider spotify "Billie Jean"
mj-open --provider qq "Billie Jean"
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

## Installation

For local development:

```bash
claude --plugin-dir .
```

Then reload plugins inside Claude Code:

```text
/reload-plugins
```

You can use `/help` to confirm the skill is available as `/moonwalk-skill:mj`.

## Project Structure

```text
moonwalk-skill/
├── .claude-plugin/
│   └── plugin.json
├── assets/
│   ├── mj-logo.svg
│   ├── mj-marketplace-icon.svg
│   ├── mj-small.svg
│   └── mjskill.png
├── bin/
│   ├── debug.sh
│   ├── mj-open
│   ├── mj-open.sh
│   ├── mj-recommend
│   ├── mj-state-write
│   ├── mj-status
│   └── mj-watch
├── data/
│   └── songs.json
├── skills/
│   └── mj/
│       └── SKILL.md
└── README.md
```

## Validation

Useful checks from the repository root:

```bash
bash -n bin/mj-open.sh
bash -n bin/mj-recommend
python3 -m json.tool .claude-plugin/plugin.json >/dev/null
python3 -m json.tool data/songs.json >/dev/null
bash ./bin/debug.sh
```

## Example Experience

```text
User: I'm tired, play some MJ

Claude:
You probably don't need anything too loud right now. These are a softer reset.
- Human Nature
- You Are Not Alone
- Butterflies

Want me to play the first one?
```

```text
User: 我今天有点烦，来点 MJ

Claude:
先别太用力，我给你挑几首能把状态慢慢拉回来的。
- Billie Jean
- Man in the Mirror
- Rock with You

要我直接放第一首吗？
```

## Notes

- This project does not host or distribute any music
- Playback redirects to official platforms such as Apple Music, Spotify, QQ Music, NetEase, or YouTube
- The skill is intentionally narrow: it is for Michael Jackson music requests, not general music playback

## License

MIT
