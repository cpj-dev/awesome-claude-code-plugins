#!/bin/bash

# Pre-commit checks for code quality
# This script runs before each commit to ensure code quality standards

set -e  # Exit on error

echo "🔍 Running pre-commit checks..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we should skip tests
SKIP_TESTS=${SKIP_TESTS:-false}

# 1. Check for staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACMR | grep -E '\.(js|ts|jsx|tsx)$' || true)

if [ -z "$STAGED_FILES" ]; then
  echo "✅ No JavaScript/TypeScript files to check"
  exit 0
fi

echo "📁 Checking ${STAGED_FILES//$'\n'/, }"

# 2. Run linter
echo ""
echo "🧹 Running linter..."
if command -v eslint &> /dev/null; then
  if eslint $STAGED_FILES; then
    echo -e "${GREEN}✅ Linting passed${NC}"
  else
    echo -e "${RED}❌ Linting failed${NC}"
    exit 1
  fi
else
  echo -e "${YELLOW}⚠️  ESLint not found, skipping...${NC}"
fi

# 3. Run type checker
echo ""
echo "📘 Running type checker..."
if command -v tsc &> /dev/null; then
  if tsc --noEmit; then
    echo -e "${GREEN}✅ Type checking passed${NC}"
  else
    echo -e "${RED}❌ Type checking failed${NC}"
    exit 1
  fi
else
  echo -e "${YELLOW}⚠️  TypeScript not found, skipping...${NC}"
fi

# 4. Run tests (if not skipped)
if [ "$SKIP_TESTS" != "true" ]; then
  echo ""
  echo "🧪 Running tests..."
  if command -v npm &> /dev/null; then
    if npm test -- --passWithNoTests; then
      echo -e "${GREEN}✅ Tests passed${NC}"
    else
      echo -e "${RED}❌ Tests failed${NC}"
      exit 1
    fi
  else
    echo -e "${YELLOW}⚠️  npm not found, skipping tests...${NC}"
  fi
else
  echo -e "${YELLOW}⚠️  Skipping tests (SKIP_TESTS=true)${NC}"
fi

# 5. Check for secrets
echo ""
echo "🔒 Scanning for secrets..."
SECRET_PATTERNS=(
  "password\s*=\s*['\"]"
  "api[_-]?key\s*=\s*['\"]"
  "secret\s*=\s*['\"]"
  "token\s*=\s*['\"]"
  "-----BEGIN PRIVATE KEY-----"
)

FOUND_SECRETS=false
for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$STAGED_FILES" | xargs grep -nE -i "$pattern" 2>/dev/null; then
    FOUND_SECRETS=true
  fi
done

if [ "$FOUND_SECRETS" = true ]; then
  echo -e "${RED}❌ Potential secrets found in code!${NC}"
  echo "Please remove sensitive data before committing."
  exit 1
else
  echo -e "${GREEN}✅ No secrets detected${NC}"
fi

# 6. Validate commit message
echo ""
echo "📝 Validating commit message..."
COMMIT_MSG_FILE=$(git rev-parse --git-dir)/COMMIT_EDITMSG
if [ -f "$COMMIT_MSG_FILE" ]; then
  COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

  # Check minimum length
  if [ ${#COMMIT_MSG} -lt 10 ]; then
    echo -e "${RED}❌ Commit message too short (minimum 10 characters)${NC}"
    exit 1
  fi

  echo -e "${GREEN}✅ Commit message valid${NC}"
fi

echo ""
echo -e "${GREEN}✅ All pre-commit checks passed!${NC}"
exit 0
