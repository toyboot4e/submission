# URL example: https://hackage.haskell.org/package/mtl-2.3.1/src/LICENSE

# $1: package
# $2: version
# $3: license name

{
indirect = ""
if ($6 == "true") { indirect = "indirect = true, " }

# http://hackage.haskell.org/package/assoc-1.1.1/src/LICENSE -> https://hackage.haskell.org/package/assoc/src/LICENSE
# ****                               ***********                    *                               *****
ver = $2
url = $5
gsub("http://", "https://", url)
gsub("-"ver, "", url)

printf\
  "library.%s = { license = [\n    { name = '%s', url = '%s' },\n], %sversion = '%s' }\n",\
    $1, $4, url, indirect, ver
}

