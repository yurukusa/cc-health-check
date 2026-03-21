set -uo pipefail
PASS=0
FAIL=0
echo "cc-health-check tests"
echo "====================="
echo ""
echo "CLI:"
EXIT=0
node "$(dirname "$0")/cli.mjs" --help > /dev/null 2>&1 || EXIT=$?
if [ "$EXIT" -eq 0 ]; then
    echo "  PASS: --help exits 0"
    PASS=$((PASS + 1))
else
    echo "  FAIL: --help (exit $EXIT)"
    FAIL=$((FAIL + 1))
fi
EXIT=0
node "$(dirname "$0")/cli.mjs" > /dev/null 2>&1 || EXIT=$?
if [ "$EXIT" -eq 0 ]; then
    echo "  PASS: normal run exits 0"
    PASS=$((PASS + 1))
else
    echo "  FAIL: normal run (exit $EXIT)"
    FAIL=$((FAIL + 1))
fi
EXIT=0
JSON_OUT=$(node "$(dirname "$0")/cli.mjs" --json 2>&1) || EXIT=$?
if [ "$EXIT" -eq 0 ]; then
    echo "  PASS: --json exits 0"
    PASS=$((PASS + 1))
else
    echo "  FAIL: --json (exit $EXIT)"
    FAIL=$((FAIL + 1))
fi
echo ""
echo "Output:"
OUTPUT=$(node "$(dirname "$0")/cli.mjs" 2>&1)
if echo "$OUTPUT" | grep -q "Score:"; then
    echo "  PASS: outputs score"
    PASS=$((PASS + 1))
else
    echo "  FAIL: no score in output"
    FAIL=$((FAIL + 1))
fi
if echo "$JSON_OUT" | python3 -c "import json,sys; json.load(sys.stdin)" 2>/dev/null; then
    echo "  PASS: --json produces valid JSON"
    PASS=$((PASS + 1))
else
    echo "  FAIL: --json invalid JSON"
    FAIL=$((FAIL + 1))
fi
echo ""
echo "====================="
TOTAL=$((PASS + FAIL))
echo "Results: $PASS/$TOTAL passed"
if [ "$FAIL" -gt 0 ]; then
    echo "FAILURES: $FAIL"
    exit 1
else
    echo "All tests passed!"
fi
