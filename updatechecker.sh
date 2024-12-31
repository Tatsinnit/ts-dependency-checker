#!/bin/bash

# Dependency Update Checker for TypeScript Projects
# ----------------------------------------------
# This script checks for outdated npm dependencies in a TypeScript project
# and displays the latest available versions.

# Ensure npm-check-updates is installed
if ! command -v ncu &> /dev/null
then
    echo "⚠️ npm-check-updates (ncu) is not installed. Installing globally..."
    npm install -g npm-check-updates
fi

# Check for updates
echo "🔍 Checking for outdated dependencies in package.json..."
ncu > dependency-updates.txt

# Display updates
if [[ -s dependency-updates.txt ]]; then
    echo "🚀 Updates available:"
    cat dependency-updates.txt
else
    echo "✅ All dependencies are up-to-date! 🎉"
fi

# Optional: Create a summary report
REPORT_FILE="dependency-updates-summary.txt"
echo "📄 Generating summary report..."

if [[ -s dependency-updates.txt ]]; then
    echo "## 📦 Dependency Updates Report" > "$REPORT_FILE"
    echo "The following dependencies have updates available:" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    cat dependency-updates.txt >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "Run 'ncu -u' to update them." >> "$REPORT_FILE"
    echo "✅ Report saved to $REPORT_FILE"
else
    echo "All dependencies are up-to-date! 🎉" > "$REPORT_FILE"
    echo "✅ Report saved to $REPORT_FILE"
fi
