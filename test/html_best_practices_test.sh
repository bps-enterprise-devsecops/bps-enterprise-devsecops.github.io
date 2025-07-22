#!/bin/bash
# Test HTML files for best practices

set -e

HTML_FILES=$(find .. -maxdepth 1 -name "*.html")

EXIT_CODE=0

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
CHECK_MARK="\xE2\x9C\x85" # ✅
CROSS_MARK="\xE2\x9D\x8C" # ❌

for file in $HTML_FILES; do
    echo "Testing $file for best practices..."

    echo "- Checking for DOCTYPE declaration..."
    if grep -q "<!DOCTYPE html>" "$file"; then
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK DOCTYPE found."
    else
        echo -e "${RED}Test failed${NC} $CROSS_MARK Missing DOCTYPE declaration."
        EXIT_CODE=1
    fi

    echo "- Checking for <meta charset>..."
    if grep -q "<meta charset=" "$file"; then
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK <meta charset> found."
    else
        echo -e "${RED}Test failed${NC} $CROSS_MARK Missing <meta charset>."
        EXIT_CODE=1
    fi

    echo "- Checking for <title> tag..."
    if grep -q "<title>" "$file"; then
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK <title> found."
    else
        echo -e "${RED}Test failed${NC} $CROSS_MARK Missing <title> tag."
        EXIT_CODE=1
    fi

    echo "- Checking for viewport meta tag..."
    if grep -q "<meta name=\"viewport\"" "$file"; then
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK viewport meta found."
    else
        echo -e "${RED}Test failed${NC} $CROSS_MARK Missing viewport meta tag."
        EXIT_CODE=1
    fi

    echo "- Checking for external or internal CSS..."
    if grep -q "<style" "$file" || grep -q "<link" "$file"; then
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK CSS found."
    else
        echo -e "${RED}Test failed${NC} $CROSS_MARK No CSS found."
        EXIT_CODE=1
    fi

    echo "- Checking for alt attribute in images..."
    if grep -q "<img" "$file"; then
        if grep -q "alt=" "$file"; then
            echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK <img> tag has alt attribute."
        else
            echo -e "${RED}Test failed${NC} $CROSS_MARK <img> tag missing alt attribute."
            EXIT_CODE=1
        fi
    else
        echo -e "${GREEN}Test succeeded${NC} $CHECK_MARK No <img> tags found, alt attribute not required."
    fi

    echo "---"
    # Add more checks as needed
done
exit $EXIT_CODE
