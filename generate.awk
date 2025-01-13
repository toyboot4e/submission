# URL example: https://hackage.haskell.org/package/mtl-2.3.1/src/LICENSE

# $1: package
# $2: version
# $3: license name

{
printf\
  "library.%s = { license = [\n    { name = '%s', url = '%s' },\n], version = '%s' }\n",\
    $1, $1, $5, $2
}

