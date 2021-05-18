# TestCoverageParser

Simple library that parses the total `lineCoverage` for given workspace and scheme from `.xcresult`.

## Usage

```
test-coverage-parser --workspace WORKSPACE --scheme SCHEME [--verbose]
```

where
* `--workspace` is the name of the workspace,
* `--scheme` is the name of the scheme,
* `--verbose` sets the library to debug mode.

The result of the call is the total line coverage, e.g.

```
0.18926
```

## Installation

### Mint

```
$ mint install LukasHromadnik/test-coverage-parser
```
