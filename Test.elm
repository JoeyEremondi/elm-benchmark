import Graphics.Element exposing (show)
import Signal
import Benchmark
import Task exposing (Task, andThen)
import Text

main =
 Signal.map (Graphics.Element.leftAligned << Text.fromString ) results.signal

mySuite =
  Benchmark.Suite "My Suite" 
  [ Benchmark.bench1 "FastFib 16" fastFib 16
  , Benchmark.bench1 "SlowFib 16" slowFib 16
  , Benchmark.bench1 "FastFib 8" fastFib 8
  , Benchmark.bench1 "SlowFib 8" slowFib 8
  ]

results : Signal.Mailbox String
results =
  Signal.mailbox "Benchmark loading"

port benchResults : (Task Benchmark.Never ())
port benchResults =
  Benchmark.runWithProgress (Just results) mySuite `andThen` \_ -> Task.succeed ()
  -- `andThen` Signal.send results.address

slowFib : Int -> Int
slowFib x = case (x < 0, x) of
  (True, _) -> 0
  (False, 0) -> 1
  (False, 1) -> 1
  _ -> (slowFib (x-1)) + (slowFib (x-2))

fastFib : Int -> Int
fastFib x = 
  let
    helper x a1 a2 = 
      if x < 2
      then a2
      else helper (x-1) x a1
  in helper x 1 1