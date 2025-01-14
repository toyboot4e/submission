#!/usr/bin/env -S bash -euE

# 事前準備:
# $ cabal-plan license-report > gen/license-report.md

# <package> <version> <package-url> <license> <license-url> 形式を生成
# $1        $2        $3            $4        $5
# なぜか attoparsec は 2 つあるので uniq しておく
cat gen/license-report.md |
  grep '^|' |
  awk -F'|' '{print $2 "\t" $3 "\t" $4}' |
  tr -d '*`[] ' |
  sed 's;(;\t;g' |
  tr -d '()' |
  grep -v Name |
  grep -v '\---' |
  sort -V |
  uniq |
  tee gen/license-report-parsed.txt > /dev/null

# 以下の形式を生成
# library.LIB-a = { license = [
#     { name = 'Apache-2.0', url = 'https://example.com/liba-license' },
# ], version = 'v0.1.2' }
cat gen/license-report-parsed.txt |
  awk -F'\t' -f generate.awk |
  tee gen/license-report-parsed-libraries.txt

