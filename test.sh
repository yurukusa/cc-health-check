#!/bin/bash
# cc-health-check smoke tests - CI compatible
# Exit codes: 0 = score>=60, 1 = score<60 (both are valid runs)
PASS=0
FAIL=0
echo "cc-health-check tests"
echo "====================="

# Test 1: runs without crashing (exit 0 or 1 both OK)
EXIT=0
node "$(dirname "$0")/cli.mjs" > /tmp/hc-out.txt 2>&1 || EXIT=$?
if [ "$EXIT" -eq 0 ] || [ "$EXIT" -eq 1 ]; then
    echo "  PASS: runs (exit $EXIT, score-based)"
    PASS=$((PASS + 1))
else
    echo "  FAIL: unexpected exit $EXIT"
    FAIL=$((FAIL + 1))
fi

# Test 2: output contains Score
if grep -q "Score" /tmp/hc-out.txt; then
    echo "  PASS: outputs score"
    PASS=$((PASS + 1))
else
    echo "  FAIL: no score"
    FAIL=$((FAIL + 1))
fi

# Test 3: --json produces parseable JSON
EXIT=0
node "$(dirname "$0")/cli.mjs" --json > /tmp/hc-json.txt 2>&1 || EXIT=$?
if node -e "JSON.parse(require('fs').readFileSync('/tmp/hc-json.txt','utf8'))" 2>/dev/null; then
    echo "  PASS: --json valid"
    PASS=$((PASS + 1))
else
    echo "  FAIL: --json invalid"
    FAIL=$((FAIL + 1))
fi

rm -f /tmp/hc-out.txt /tmp/hc-json.txt
echo "====================="
echo "Results: $PASS/$((PASS+FAIL)) passed"
[ "$FAIL" -gt 0 ] && exit 1 || exit 0
