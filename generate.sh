#!/usr/bin/env -S bash -euE

# 事前準備:
# $ cabal-plan license-report > gen/license-report.md

# <package> <version> <license> 形式を生成
cat gen/license-report.md |
  grep '^|' |
  awk -F'|' '{print $2 "\t" $3 "\t" $4}' |
  tr -d '*`[] ' |
  sed 's;([^)]*);;g' |
  grep -v Name |
  grep -v '\---' |
  sort -V |
  tee gen/license-report-parsed.txt > /dev/null

# 以下の形式を生成
# library.LIB-a = { license = [
#     { name = 'Apache-2.0', url = 'https://example.com/liba-license' },
# ], version = 'v0.1.2' }
cat gen/license-report-parsed.txt |
  awk -F'\t' -f generate.awk |
  tee gen/license-report-parsed-libraries.txt

