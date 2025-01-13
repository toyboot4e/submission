#!/usr/bin/env -S bash -euE

# cabal-plan license-report > license-report.md

cat gen/license-report.md |
  grep '^|' |
  awk -F'|' '{print $2 "\t" $3 "\t" $4}' |
  tr -d '*`[] ' |
  sed 's;([^)]*);;g' |
  grep -v Name |
  grep -v '\---' |
  sort -V |
  tee gen/license-report-parsed.txt

