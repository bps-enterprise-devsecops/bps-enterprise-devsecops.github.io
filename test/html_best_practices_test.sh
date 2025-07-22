#!/bin/bash
# Test HTML files for best practices

set -e

HTML_FILES=$(find .. -maxdepth 1 -name "*.html")

EXIT_CODE=0

for file in $HTML_FILES; do
    echo "Testing $file for best practices..."
    # Check for DOCTYPE
    if ! grep -q "<!DOCTYPE html>" "$file"; then
        echo "[FAIL] $file: Missing DOCTYPE declaration."
        EXIT_CODE=1
    fi
    # Check for <meta charset>
    if ! grep -q "<meta charset=" "$file"; then
        echo "[FAIL] $file: Missing <meta charset>."
        EXIT_CODE=1
    fi
    # Check for <title>
    if ! grep -q "<title>" "$file"; then
        echo "[FAIL] $file: Missing <title> tag."
        EXIT_CODE=1
    fi
    # Check for viewport meta
    if ! grep -q "<meta name=\"viewport\"" "$file"; then
        echo "[FAIL] $file: Missing viewport meta tag."
        EXIT_CODE=1
    fi
    # Check for external or internal CSS
    if ! grep -q "<style" "$file" && ! grep -q "<link" "$file"; then
        echo "[FAIL] $file: No CSS found."
        EXIT_CODE=1
    fi
    # Check for alt attribute in images
    if grep -q "<img" "$file" && ! grep -q "alt=" "$file"; then
        echo "[FAIL] $file: <img> tag missing alt attribute."
        EXIT_CODE=1
    fi
    echo "[PASS] $file: Basic best practices checks passed."
    echo "---"
    
    # Add more checks as needed

done
exit $EXIT_CODE
