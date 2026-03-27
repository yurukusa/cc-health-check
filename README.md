# cc-health-check

[![npm version](https://img.shields.io/npm/v/cc-health-check)](https://www.npmjs.com/package/cc-health-check)
[![npm downloads](https://img.shields.io/npm/dw/cc-health-check)](https://www.npmjs.com/package/cc-health-check)
[![tests](https://github.com/yurukusa/cc-health-check/actions/workflows/test.yml/badge.svg)](https://github.com/yurukusa/cc-health-check/actions/workflows/test.yml)

> **Is your Claude Code setup actually production-ready?**
>
> 700+ hours of autonomous AI operation taught us what breaks first. This tool checks your setup against 20 real failure patterns — in 30 seconds.

```
npx cc-health-check
```

**No installation required. Nothing leaves your machine.**

---

## Why this exists

Claude Code can run autonomously for hours. But most setups aren't built for that. Files get deleted. Costs spike. The AI loops on errors. Push-to-main happens without review.

These aren't hypothetical. They're what actually happens without the right guardrails.

cc-health-check scans your `.claude/settings.json` and `CLAUDE.md` for 20 known failure patterns, gives you a score, and tells you exactly what to fix.

---

## Quick start (no install)

**Web version** — paste in your CLAUDE.md, get your score instantly:
👉 https://yurukusa.github.io/cc-health-check/

**CLI** — scans your local setup automatically:
```bash
npx cc-health-check
```

---

## What it checks

| Dimension | Checks | What it looks for |
|-----------|--------|-------------------|
| Safety Guards | 4 | PreToolUse hooks, secret handling, branch protection, error gates |
| Code Quality | 4 | Syntax checking, error tracking, DoD checklists, output verification |
| Monitoring | 3 | Context window alerts, activity logging, daily summaries |
| Recovery | 3 | Backup branches, watchdog, loop detection |
| Autonomy | 3 | Task queues, question blocking, persistent state |
| Coordination | 3 | Decision logs, multi-agent support, lesson capture |

## Sample output

```
  Claude Code Health Check v1.0
  ═══════════════════════════════════════

  ▸ Safety Guards
    [PASS] PreToolUse hook blocks dangerous commands
    [PASS] API keys stored in dedicated files
    [FAIL] Setup prevents pushing to main/master without review
    [PASS] Error-aware gate blocks external calls when errors exist

  Score: 63/100 — Getting There

  Top fixes:
    → Add a PreToolUse hook that blocks destructive commands.
    → Scan bash output for error patterns in PostToolUse hooks.
```

## Scores

| Score | Grade |
|-------|-------|
| 80-100 | Production Ready |
| 60-79 | Getting There |
| 35-59 | Needs Work |
| 0-34 | Critical |

---

## Got a low score?

**Quickest fix:** `npx cc-safe-setup` — 8 safety hooks in 10 seconds. Score jumps from ~30 to ~80.

**Full fix:** [Claude Code Ops Kit](https://yurukusa.github.io/cc-ops-kit-landing/?utm_source=github&utm_medium=readme&utm_campaign=ops-kit&ref=health-check-low-score) — 6 hooks + 5 templates + 9 scripts. Pay what you want ($0+).

---

## How it works

1. Reads `~/.claude/settings.json` for hook configurations
2. Scans `CLAUDE.md` files (global + project) for patterns
3. Checks for common files (`mission.md`, `proof-log/`, `task-queue.yaml`)
4. Scores each check (pass/fail) and calculates dimension scores
5. Outputs actionable recommendations with one-click install commands:
   ```
   → Add a PreToolUse hook that blocks destructive commands.
     $ npx cc-safe-setup --install-example rm-safety-net
   ```

**Zero dependencies. No data sent anywhere. Runs entirely local.**

## JSON output

```bash
npx cc-health-check --json
```

Returns structured JSON with score, grade, dimensions, and per-check results. Useful for CI pipelines, dashboards, or programmatic analysis.

## README badge

```bash
npx cc-health-check --badge
```

Generates a shields.io badge URL for your README:

![Claude Code Health](https://img.shields.io/badge/Claude%20Code%20Health-95%25%20%E2%80%94%20Production%20Ready-brightgreen)

## CI integration

Exit code `0` if score >= 60, `1` otherwise.

```yaml
# .github/workflows/health-check.yml
name: Claude Code Health Check
on:
  push:
    paths: ['.claude/**', 'CLAUDE.md']
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npx cc-health-check@latest
```

---

## The cc-toolkit

| Tool | What it does |
|------|--------------|
| **cc-health-check** | Is your AI **setup** safe? (you are here) |
| [cc-safe-setup](https://github.com/yurukusa/cc-safe-setup) | **Fix your score in 10 seconds** — `npx cc-safe-setup` |
| [claude-code-hooks](https://github.com/yurukusa/claude-code-hooks) | All 16 hooks + 6 templates (free OSS) |
| [cc-session-stats](https://github.com/yurukusa/cc-session-stats) | How much are you **using** AI? |
| [cc-audit-log](https://github.com/yurukusa/cc-audit-log) | What did your AI **do**? |
| [cc-cost-check](https://github.com/yurukusa/cc-cost-check) | Cost per commit calculator |
| [cc-wrapped](https://yurukusa.github.io/cc-wrapped/) | Your AI year in review |
| [cc-roast](https://yurukusa.github.io/cc-roast/) | Your CLAUDE.md, brutally honest |

### Need it all set up?

**Quick fix (free):** `npx cc-safe-setup` — 8 hooks, 10 seconds, score jumps from 50 to 95.

**[Claude Code Ops Kit](https://yurukusa.github.io/cc-ops-kit-landing/?utm_source=github&utm_medium=readme&utm_campaign=ops-kit&ref=health-check)** — 6 hooks + 5 templates + 9 scripts + install.sh. Fix everything cc-health-check found in 15 minutes. Pay what you want ($0+).

If cc-health-check helped you improve your setup, consider giving it a ⭐ — it helps others find this tool.

## License

MIT
