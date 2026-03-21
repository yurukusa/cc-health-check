#!/bin/bash
# cc-health-check smoke tests
set -euo pipefail

PASS=0
FAIL=0

test_cmd() {
    local desc="$1" cmd="$2" expected_exit="$3"
    local actual_exit=0
    eval "$cmd" > /dev/null 2>&1 || actual_exit=$?
    if [ "$actual_exit" -eq "$expected_exit" ]; then
        echo "  PASS: $desc"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: $desc (expected exit $expected_exit, got $actual_exit)"
        FAIL=$((FAIL + 1))
    fi
}

echo "cc-health-check tests"
echo "====================="
echo ""

# CLI smoke tests
echo "CLI:"
test_cmd "--help exits 0" "node $(dirname $0)/cli.mjs --help" 0
test_cmd "normal run exits 0" "node $(dirname $0)/cli.mjs" 0
test_cmd "--json exits 0" "node $(dirname $0)/cli.mjs --json" 0
echo ""

# Output validation
echo "Output:"
output=$(node "$(dirname $0)/cli.mjs" 2>&1)
if echo "$output" | grep -q "Score:"; then
    echo "  PASS: outputs score"
    PASS=$((PASS + 1))
else
    echo "  FAIL: no score in output"
    FAIL=$((FAIL + 1))
fi

if echo "$output" | grep -q "Safety Guards"; then
    echo "  PASS: shows Safety Guards dimension"
    PASS=$((PASS + 1))
else
    echo "  FAIL: missing Safety Guards dimension"
    FAIL=$((FAIL + 1))
fi

json_output=$(node "$(dirname $0)/cli.mjs" --json 2>&1)
if echo "$json_output" | python3 -c "import json,sys; json.load(sys.stdin)" 2>/dev/null; then
    echo "  PASS: --json produces valid JSON"
    PASS=$((PASS + 1))
else
    echo "  FAIL: --json invalid JSON"
    FAIL=$((FAIL + 1))
fi
echo ""

# Summary
echo "====================="
TOTAL=$((PASS + FAIL))
echo "Results: $PASS/$TOTAL passed"
if [ "$FAIL" -gt 0 ]; then
    echo "FAILURES: $FAIL"
    exit 1
else
    echo "All tests passed!"
fi
