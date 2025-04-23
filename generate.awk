# URL example: https://hackage.haskell.org/package/mtl-2.3.1/src/LICENSE

# $1: package
# $2: version
# $3: license name

{
indirect = ""
if ($6 == "true") { indirect = "indirect = true, " }
printf\
  "library.%s = { license = [\n    { name = '%s', url = '%s' },\n], %s version = '%s' }\n",\
    $1, $4, $5, indirect, $2
}

