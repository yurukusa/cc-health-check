# cc-health-check

CLI diagnostic for your Claude Code setup. 20 automated checks across 6 dimensions.

```
npx cc-health-check
```

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

  ▸ Code Quality
    [PASS] Syntax checks run after every file edit
    [FAIL] Error detection and tracking from command output
    ...

  Score: 63/100 — Getting There

  Dimensions:
    ███████████░░░░░░░░░ Safety Guards 55%
    ██████████░░░░░░░░░░ Code Quality 50%
    ...

  Top fixes:
    → Add a PreToolUse hook that blocks destructive commands.
    → Scan bash output for error patterns in PostToolUse hooks.

  Production hooks + templates for autonomous Claude Code:
  https://yurukusa.gumroad.com/l/cc-codex-ops-kit
```

## How it works

1. Reads `~/.claude/settings.json` for hook configurations
2. Scans `CLAUDE.md` files (global + project) for patterns
3. Checks for common files (`mission.md`, `proof-log/`, `task-queue.yaml`)
4. Scores each check (pass/fail) and calculates dimension scores
5. Outputs actionable recommendations sorted by impact

**Zero dependencies. No data sent anywhere. Runs entirely local.**

## Scores

| Score | Grade |
|-------|-------|
| 80-100 | Production Ready |
| 60-79 | Getting There |
| 35-59 | Needs Work |
| 0-34 | Critical |

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

Or save a JSON report as artifact:

```bash
npx cc-health-check --json > health-report.json
```

## The cc-toolkit trilogy

| Tool | What it checks |
|------|---------------|
| **cc-health-check** | Is your AI **setup** safe? |
| [cc-session-stats](https://github.com/yurukusa/cc-session-stats) | How much are you **using** AI? |
| [cc-audit-log](https://github.com/yurukusa/cc-audit-log) | What did your AI **do**? |
| [cc-cost-check](https://github.com/yurukusa/cc-cost-check) | Cost per commit calculator |
| [cc-wrapped](https://yurukusa.github.io/cc-wrapped/) | Your AI year in review (Spotify Wrapped style) |

## Also available

**[Web version](https://yurukusa.github.io/cc-health-check/)** — Interactive 20-question checklist with the same scoring.

## License

MIT
