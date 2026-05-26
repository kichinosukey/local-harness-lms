# local-harness-lms

`local-harness-lms` provides a thin launcher command, `lh-lms`, for pointing Claude Code at an LM Studio local endpoint.

The first supported harness is Claude Code. Codex is planned / not implemented.

This tool does not reimplement Claude Code, LM Studio, an Anthropic/OpenAI API translation proxy, automatic model loading, or generation-parameter injection. It only selects a small model profile, exports the environment variables Claude Code needs, and passes the remaining arguments through to `claude`.

## Install

Clone or copy this repository, then put `lh-lms` on your `PATH`.

```bash
chmod +x lh-lms
./lh-lms list profiles
```

LM Studio should be serving on:

```text
ANTHROPIC_BASE_URL=http://127.0.0.1:1234
```

The launcher also sets:

```text
CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
```

## Usage

```bash
./lh-lms list profiles
./lh-lms list harnesses
./lh-lms env claude gemma
./lh-lms load-command gemma
./lh-lms doctor claude gemma
./lh-lms claude gemma -- -p "OKだけ返して"
```

`./lh-lms claude <profile> [--] [claude args...]` sets:

```text
ANTHROPIC_BASE_URL=http://127.0.0.1:1234
ANTHROPIC_AUTH_TOKEN=dummy
ANTHROPIC_MODEL=<profile identifier>
CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
```

It also adds a default Claude Code debug log path:

```text
/tmp/lh-lms-claude-<profile>-<timestamp>.log
```

## Profiles

| Profile | Identifier | LM Studio model key | Context length | Intended use |
| --- | --- | --- | --- | --- |
| `gemma` | `gemma-4-e4b-128k` | `gemma-4-e4b-it` | `131072` | gemma is for lightweight read-only, brainstorming, and handoff reading |
| `qwen` | `qwen3.6-27b-mlx-98k` | `qwen3.6-27b-mlx` | `100352` | qwen is for heavy evaluation only and is not recommended for daily use |

`gemma` is not positioned as a complex autonomous implementation model. `qwen` can be useful for high-load evaluation, but it is not a daily-use recommendation.

## LM Studio Load Commands

`lh-lms` does not run `lms load` automatically. Use `load-command` to print the command and decide whether to run it yourself.

```bash
./lh-lms load-command gemma
# lms load gemma-4-e4b-it --context-length 131072 --identifier gemma-4-e4b-128k

./lh-lms load-command qwen
# lms load qwen3.6-27b-mlx --context-length 100352 --identifier qwen3.6-27b-mlx-98k
```

## Harnesses

```bash
./lh-lms list harnesses
```

Current status:

| Harness | Status |
| --- | --- |
| `claude` | supported |
| `codex` | planned / not implemented |

The Codex adapter is intentionally not implemented in this initial version.

## Doctor

```bash
./lh-lms doctor claude gemma
```

`doctor` checks whether the `claude` command is available, whether the LM Studio `lms` command is available, whether `127.0.0.1:1234` appears to be listening, and whether the requested harness/profile pair is supported.

## Limitations

- Claude Code must already be installed.
- LM Studio must already be installed and serving on `127.0.0.1:1234`.
- Model loading is manual; `lh-lms` only prints load commands.
- Codex support is planned / not implemented.
- No Anthropic Messages API to OpenAI-compatible API translation proxy is included.
- No generation parameters are injected into request payloads.
- No LM Studio runtime behavior is reimplemented.
- No private tokens, personal `.envrc` files, or secrets are needed.
