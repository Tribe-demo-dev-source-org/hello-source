#!/usr/bin/env bash
# Demo stand-in for the Veracode gate (doc section 4.3).
#
# Scans the tree of one commit, which is passed in as data and never checked out
# or executed, and fails if any file under app/ or infra/ contains the demo marker.
# In the real design this step runs Veracode Pipeline Scan (static) plus SCA and
# blocks on any open Critical (Very High) or High finding.
#
# Usage: scripts/veracode-standin.sh <40-char-sha>
set -euo pipefail

sha="${1:?usage: veracode-standin.sh <sha>}"
summary="${GITHUB_STEP_SUMMARY:-/dev/null}"
# Built from two halves so this script never matches its own marker.
marker="DEMO-""FINDING"

if hits="$(git grep -n -I -e "$marker" "$sha" -- app/ infra/)"; then
  echo "::error::Veracode gate (demo stand-in): High finding in ${sha}"
  echo "$hits"
  {
    echo "### Veracode gate (demo stand-in): FAILED"
    echo "Commit \`${sha}\` contains a simulated High finding:"
    echo '```'
    echo "$hits"
    echo '```'
    echo "main does not move and QA does not deploy."
  } >> "$summary"
  exit 1
fi

echo "Veracode gate (demo stand-in): no Critical or High findings in ${sha}"
{
  echo "### Veracode gate (demo stand-in): PASSED"
  echo "No Critical or High findings in \`${sha}\`."
} >> "$summary"
