import Graphics.Element exposing (show)
import Signal
import Benchmark
import Task exposing (Task, andThen)

main = Signal.map show results.signal

mySuite =
  Benchmark.Suite "My Suite" 
  [ Benchmark.bench1 "FastFib" fastFib 2
  , Benchmark.bench1 "SlowFib" slowFib 2
  ]

results : Signal.Mailbox String
results =
  Signal.mailbox "Benchmark loading"

port benchResults : (Task Benchmark.Never ())
port benchResults =
  Benchmark.run mySuite `andThen` Signal.send results.address

slowFib : Int -> Int
slowFib x = case x of
  0 -> 1
  0 -> 1
  _ -> (slowFib x-1) + (slowFib x-2)

fastFib : Int -> Int
fastFib x = 
  let
    helper x a1 a2 = 
      if x < 2
      then a2
      else helper (x-1) x a1
  in helper x 1 1