# PostgresRunway

Show tables which are using the most of their available ID sequences.

## Usage

```
mix run -e PostgresRunway.CLI.main
```

There's a bunch of stuff that this could or should do that it doesn't, in the interest of me spiking out my first solo Elixir project. In no particular order:

* Reading DB connection information from environment or a file (or even command arguments), for usage in multiple contexts
* Packaging up into a binary to run on production environments
* Better display of the available information
* Exit non-zero in case a table crosses a given threshold of usage percentage, for use in monitoring
* TESTS!

