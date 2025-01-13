# URL example: https://hackage.haskell.org/package/mtl-2.3.1/src/LICENSE

# $1: package
# $2: version
# $3: license name

{
printf\
  "library.%s = { license = [\n    { name = '%s', url = 'https://hackage.haskell.org/package/%s-%s/src/LICENSE' },\n], version = '%s' }\n",\
  $1, $3, $1, $2, $2
}

