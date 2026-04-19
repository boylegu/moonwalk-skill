<div align="center">
<p align="center">
<img src="https://cdn.jsdelivr.net/gh/boylegu/moonwalk-skill/assets/mjskill.png?raw=true" width="300" height="300" alt="Moonwalk Skill 预览图">
</p>

<p>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="license" />
  <img src="https://img.shields.io/badge/platform-Claude%20Code-blue?style=for-the-badge" alt="platform" />
  <img src="https://img.shields.io/badge/type-plugin-orange?style=for-the-badge" alt="type" />
  <img src="https://img.shields.io/badge/status-active-success?style=for-the-badge" alt="status" />
</p>
</div>

# moonwalk-skill

[English](./README.md) | 简体中文

Moonwalk Skill 是一个面向 Claude Code 的定向音乐插件，聚焦 Michael Jackson 曲库。它能识别简单情绪或场景，推荐当下更合适的歌曲，并快速打开对应曲目。

这是一款独立的粉丝插件项目，与 Michael Jackson 遗产管理方或任何官方权利人无隶属、认可、赞助或授权关系。

## 它能做什么

- 根据情绪、场景或活动推荐 2-4 首歌
- 支持直接点歌，例如 `Billie Jean`、`Human Nature`
- 当你表现出疲惫、低落、烦躁或怀旧时，先给一句简短克制的回应
- 通过支持的平台打开选中的歌曲
- 同时支持自然语言使用和 `/moonwalk-skill:mj` 直接调用

## 什么时候适合用

当你想听点对味的歌，又不想把请求说得太复杂时，这个插件会比较顺手：

- 已经知道歌名，只想尽快打开
- 想要几首适合写代码、专注、深夜或放松时听的歌
- 状态不太对，想听更柔和一点的歌
- 想在一套固定曲库里找推荐，不想做泛音乐搜索

你可以这样说：

```text
我想听 Billie Jean
给我来点适合写代码的
来点适合深夜听的
我今天有点烦，放点柔和一点的
/moonwalk-skill:mj Billie Jean
```

## 它会怎么回应

自然语言就是默认入口。

1. 如果你直接点歌，它会直接打开对应歌曲。
2. 如果你想表达一些情绪、场景或当下状态，它会先推荐 2-4 首歌。
3. 如果语气比较低落，它会先补一句简短克制的回应。
4. 如果你说“好”或者“放第一首”，它会直接打开首选推荐。

这个插件的定位是刻意收窄的。它只处理 Michael Jackson 音乐请求，不做通用音乐播放器或艺人发现。

## 支持的平台

- `auto`
- `youtube`
- `ytmusic`
- `spotify`
- `apple`
- `qq`
- `netease`

自动路由规则：

- 中文请求默认使用 `qq`
- 英文请求在 macOS 下默认使用 `apple`
- 英文请求在非 macOS 环境下默认使用 `spotify`
- 如果需要明确指定平台，则始终以指定平台为准

打开行为：

- `spotify` 优先尝试本地 Spotify 客户端，失败后回退到网页搜索
- `apple` 优先尝试本地 Music 应用，失败后回退到网页搜索
- `qq`、`netease`、`youtube`、`ytmusic` 直接打开网页搜索

## 行为边界与限制

- 本项目不托管、不分发任何音乐内容
- 本项目是独立作品，不是 Michael Jackson 官方产品
- 播放行为会跳转到 Apple Music、Spotify、QQ 音乐、网易云或 YouTube 等外部平台
- 实际打开效果依赖本地操作系统、浏览器和已安装应用
- 某些平台可能打开的是搜索页，而不是直接播放
- 插件只处理 Michael Jackson 相关音乐请求

## 安装方式

如果要通过 GitHub 安装，先把这个仓库加入你本地的 marketplace 来源：

```text
/plugin marketplace add boylegu/moonwalk-skill
```

然后再安装插件本身：

```text
/plugin install moonwalk-skill@mj-music
```

`marketplace add` 只是在你自己的 Claude Code 环境里登记这个仓库。别人如果也要安装，仍然需要在各自环境里执行同样的 `add`。

如果 marketplace 目录有更新，可以刷新本地 marketplace 条目：

```text
/plugin marketplace update mj-music
```

如果插件本身发了新版本，再更新已经安装的版本：

```text
/plugin update moonwalk-skill@mj-music
```

## 使用方式

### 自然语言

这是默认且推荐的使用方式。当你的表达明显是在请求 Michael Jackson 音乐时，Claude 会自动触发这个 skill。

### 直接调用 skill

这个方式主要用于调试或强制触发：

```text
/moonwalk-skill:mj Billie Jean
/moonwalk-skill:mj coding
/moonwalk-skill:mj 我今天有点烦，来点 MJ
```

## 本地命令

先把 `bin/` 加入 `PATH`：

```bash
export PATH="$PWD/bin:$PATH"
```

### `mj-recommend`

根据情绪或场景返回 2-4 首 MJ 歌曲：

```bash
mj-recommend coding
mj-recommend "我今天有点烦"
mj-recommend "想怀旧一点"
```

### `mj-open`

按指定平台打开歌曲：

```bash
mj-open "Billie Jean"
mj-open --provider auto "Billie Jean"
mj-open --provider qq "Billie Jean"
mj-open --provider spotify "Billie Jean"
```

### `mj-status`

输出最近一次插件状态：

```bash
mj-status
```

### `mj-watch`

循环刷新最近一次状态：

```bash
mj-watch
```

### `debug.sh`

执行语法检查、JSON 校验和示例命令：

```bash
bash ./bin/debug.sh
```

## 补充曲库

如果你想继续往曲库里加歌，可以编辑 [`data/songs.json`](./data/songs.json) 就可以。

每一项尽量保持这种结构：

```json
{
  "title": "Song Title",
  "tags": ["coding", "night", "comfort"]
}
```

`tags` 建议沿用现有词汇，尽量不要新增重复标签。推荐逻辑本身就是靠这些标签匹配的，所以标签越稳定，结果越自然。

改完之后，至少跑一下：

```bash
python3 -m json.tool data/songs.json >/dev/null
bash ./bin/debug.sh
```

## 验证命令

在仓库根目录下可运行：

```bash
bash -n bin/mj-open.sh
bash -n bin/mj-recommend
python3 -m json.tool .claude-plugin/plugin.json >/dev/null
python3 -m json.tool .claude-plugin/marketplace.json >/dev/null
python3 -m json.tool data/songs.json >/dev/null
bash ./bin/debug.sh
```

## 许可证

MIT
