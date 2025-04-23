#!/usr/bin/env -S bash -euE

# 事前準備: `gen/license-report.md` を生成する
# $ cp /path/to/license-report.md gen

# `license-report-direct.md`, `license-report-indirect.md` を生成
cat gen/license-report.md | awk 'BEGIN {RS="## "} NR==2 {print "## " $0}' > gen/license-report-direct.md
cat gen/license-report.md | awk 'BEGIN {RS="## "} NR==3 {print "## " $0}' > gen/license-report-indirect.md

# <package> <version> <package-url> <license> <license-url> <direct> 形式を生成
# $1        $2        $3            $4        $5            $6
f() {
  cat "$1" |
    grep '^|' |
    grep -v '^| Name' |
    grep -v '^| ---' |
    awk -F'|' '{print $2 "\t" $3 "\t" $4}' |
    tr -d '*`[] ' |
    sed 's;(;\t;g' |
    tr -d '()' |
    sed 's;$;'"\t$2;g"
}

direct="$(f 'gen/license-report-direct.md' false)"
indirect="$(f 'gen/license-report-indirect.md' true)"
printf '%s\n%s' "$direct" "$indirect" | sort -V > gen/license-report-parsed.txt

# 以下の形式を生成
# library.LIB-a = { license = [
#     { name = 'Apache-2.0', url = 'https://example.com/liba-license' },
# ], indirect = true, version = 'v0.1.2' }
cat gen/license-report-parsed.txt |
  awk -F'\t' -f generate.awk > gen/license-report-libraries.txt

# for cabal.project
printf '%s' "$direct" | sort -V | awk -F'\t' '{print $1 " ^>=" $2}' > gen/license-report-direct-dependencies

# 手動修正
# - ghc-boot-th
# - atto-parsec
