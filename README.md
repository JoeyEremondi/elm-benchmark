# elm-benchmark: Benchmarking for Elm based on benchmark.js

## Usage

To create a single benchmark, use the `bench1 ... bench9` functions:

```elm
myfun x y z = x + y + z

myBenchmark = bench3 myfun 3 4 5
```

Multiple benchmarks can be combined into a named suite, using the `Suite` constructor:

```elm
mySuite =
  Benchmark.Suite "My Suite" 
  [ Benchmark.bench1 "FastFib 16" fastFib 16
  , Benchmark.bench1 "SlowFib 16" slowFib 16
  , Benchmark.bench1 "FastFib 8" fastFib 8
  , Benchmark.bench1 "SlowFib 8" slowFib 8
  ]
```

Suites can then be run using the `run` function, which creates a `Task`.
The result of this task has type `(String,  List Benchstats)`, 
where `BenchStats` is a record-type of data for each benchmark.

Since benchmarks are often long-running, there is a variant of `run` which allows for
updates to be displayed as text. There's `runWithProgress`, a generalization of `run`:

```elm
runWithProgress 
  :  Maybe (Signal.Mailbox String) 
  -> Suite 
  -> Task.Task Never (String, List BenchStats)
```

When a `Just` value is given for the mailbox, a string indicating the progress of the benchmarks is
periodically sent to the given mailbox.

A full example can be found in `Test.elm`.
