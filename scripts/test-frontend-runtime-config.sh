#!/bin/bash
# Test script for frontend runtime environment configuration

set -e

echo "========================================="
echo "  Testing Frontend Runtime Configuration"
echo "========================================="
echo ""

cd "$(dirname "$0")/.."

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper function to run a test
run_test() {
  local test_name="$1"
  local test_cmd="$2"
  
  echo -n "Testing: $test_name ... "
  if eval "$test_cmd" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((TESTS_PASSED++))
  else
    echo -e "${RED}✗ FAIL${NC}"
    ((TESTS_FAILED++))
  fi
}

echo "1. Checking file modifications..."
echo ""

# Check if entrypoint scripts exist
run_test "roadfx-web entrypoint script exists" \
  "[ -f repos/roadfx-web/docker-entrypoint.sh ]"

run_test "roadfx-widget-js entrypoint script exists" \
  "[ -f repos/roadfx-widget-js/docker-entrypoint.sh ]"

# Check if entrypoint scripts are executable
run_test "roadfx-web entrypoint is executable" \
  "[ -x repos/roadfx-web/docker-entrypoint.sh ]"

run_test "roadfx-widget-js entrypoint is executable" \
  "[ -x repos/roadfx-widget-js/docker-entrypoint.sh ]"

echo ""
echo "2. Checking Dockerfile modifications..."
echo ""

# Check if Dockerfiles have COPY docker-entrypoint.sh
run_test "roadfx-web Dockerfile copies entrypoint" \
  "grep -q 'COPY docker-entrypoint.sh' repos/roadfx-web/Dockerfile"

run_test "roadfx-widget-js Dockerfile copies entrypoint" \
  "grep -q 'COPY docker-entrypoint.sh' repos/roadfx-widget-js/Dockerfile"

# Check if Dockerfiles have ENTRYPOINT
run_test "roadfx-web Dockerfile has ENTRYPOINT" \
  "grep -q 'ENTRYPOINT.*docker-entrypoint.sh' repos/roadfx-web/Dockerfile"

run_test "roadfx-widget-js Dockerfile has ENTRYPOINT" \
  "grep -q 'ENTRYPOINT.*docker-entrypoint.sh' repos/roadfx-widget-js/Dockerfile"

echo ""
echo "3. Checking HTML modifications..."
echo ""

# Check if index.html files load env-config.js
run_test "roadfx-web index.html loads env-config.js" \
  "grep -q 'env-config.js' repos/roadfx-web/index.html"

run_test "roadfx-widget-js index.html loads env-config.js" \
  "grep -q 'env-config.js' repos/roadfx-widget-js/index.html"

echo ""
echo "4. Checking frontend code modifications..."
echo ""

# Check if api.ts reads from window.ENV
run_test "roadfx-web api.ts reads window.ENV" \
  "grep -q 'window.*ENV.*VITE_API_BASE_URL' repos/roadfx-web/src/services/api.ts"

# Check if url.ts reads from window.ENV
run_test "roadfx-web url.ts reads window.ENV" \
  "grep -q 'window.*ENV.*VITE_API_BASE_URL' repos/roadfx-web/src/utils/url.ts"

# Check if App.tsx reads from window.ENV
run_test "roadfx-widget-js App.tsx reads window.ENV" \
  "grep -q 'window.*ENV.*VITE_API_BASE' repos/roadfx-widget-js/src/App.tsx"

echo ""
echo "5. Checking docker-compose modifications..."
echo ""

# Check if docker-compose.yml has environment variables
run_test "docker-compose.yml has API_BASE_URL for roadfx-web" \
  "grep -A 5 'roadfx-web:' docker-compose.yml | grep -q 'API_BASE_URL'"

run_test "docker-compose.yml has API_BASE_URL for roadfx-widget-js" \
  "grep -A 5 'roadfx-widget-js:' docker-compose.yml | grep -q 'API_BASE_URL'"

# Check if docker-compose.source.yml has environment variables
run_test "docker-compose.source.yml has API_BASE_URL for roadfx-web" \
  "grep -A 5 'roadfx-web:' docker-compose.source.yml | grep -q 'API_BASE_URL'"

run_test "docker-compose.source.yml has API_BASE_URL for roadfx-widget-js" \
  "grep -A 5 'roadfx-widget-js:' docker-compose.source.yml | grep -q 'API_BASE_URL'"

echo ""
echo "6. Checking documentation..."
echo ""

# Check if documentation files exist
run_test "RUNTIME_ENV_CONFIG.md exists" \
  "[ -f docs/RUNTIME_ENV_CONFIG.md ]"

run_test "FRONTEND_RUNTIME_CONFIG_QUICK_START.md exists" \
  "[ -f docs/FRONTEND_RUNTIME_CONFIG_QUICK_START.md ]"

echo ""
echo "========================================="
echo "  Test Results"
echo "========================================="
echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
  echo -e "${GREEN}✓ All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}✗ Some tests failed${NC}"
  exit 1
fi

