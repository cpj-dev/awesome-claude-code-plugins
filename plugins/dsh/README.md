# dsh

Claude Code plugin that bridges to the [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) (`dsh`) agent for review, critique, delegation, and resumable sessions.

Source marketplace: [cpj-dev/dsh-plugin-cc](https://github.com/cpj-dev/dsh-plugin-cc)

## Install

From this collection:

```bash
/plugin marketplace add hekmon8/awesome-claude-code-plugins
/plugin install dsh
```

Or from the source marketplace:

```bash
/plugin marketplace add cpj-dev/dsh-plugin-cc
/plugin install dsh@deepseek-dsh
```

Then run `/dsh:setup` once (`DEEPSEEK_API_KEY`, Node >= 20).

## Commands

- `/dsh:check` — readiness probe
- `/dsh:setup` — install/link dsh and the multi-turn profile
- `/dsh:review` — read-only review of local changes
- `/dsh:critique` — adversarial design critique
- `/dsh:delegate <task>` — background delegation
- `/dsh:run <task>` — one-shot or resumable session
- `/dsh:import` — import this conversation into a dsh session
- `/dsh:runs` / `/dsh:show` / `/dsh:stop` — job control

License: MIT
