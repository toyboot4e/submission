# Just a task runner
# <https://github.com/casey/just>

# shows this help message
help:
    @just -l

# runs the generate script
run:
    cabal update
    cabal build
    cabal-plan license-report main > gen/license-report.md
    ./generate.sh

