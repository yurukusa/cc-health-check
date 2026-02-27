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

  Fix all 20 checks at once:
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

## Exit codes

- `0` — Score >= 60 (passing)
- `1` — Score < 60 (failing)

Useful for CI: `npx cc-health-check || echo "Setup needs work"`

## Companion tool

**[cc-session-stats](https://github.com/yurukusa/cc-session-stats)** — See how much time you actually spend with Claude Code. Session durations, daily patterns, health warnings.

## Also available

**[Web version](https://yurukusa.github.io/cc-health-check/)** — Interactive 20-question checklist with the same scoring.

## License

MIT
