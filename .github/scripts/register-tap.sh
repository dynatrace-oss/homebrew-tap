#!/usr/bin/env bash
# Expose the checked-out casks to Homebrew as the dynatrace-oss/tap tap, so
# they can be referenced by name. Homebrew rejects casks that are not in a
# tap, and requires a tap to be a git repository.
set -euo pipefail

tap_dir="$(brew --repository)/Library/Taps/dynatrace-oss/homebrew-tap"

rm -rf "$tap_dir"
mkdir -p "$tap_dir"
cp -R Casks "$tap_dir/"

git -C "$tap_dir" init -q
git -C "$tap_dir" add -A
git -C "$tap_dir" -c user.email=ci@local -c user.name=ci commit -qm "ci tap"

echo "Registered $(ls "$tap_dir/Casks" | wc -l | tr -d ' ') casks at $tap_dir"
