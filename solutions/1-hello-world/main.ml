(*
  Step 1 - Run this Hello World example

  Tasks
  1. In your terminal inside the dev container, run

    opam exec -- dune exec main

  2. open http://localhost:8080 in your browser
     and confirm that "Hello world!" is being displayed
*)

let () = Dream.run (fun _ -> Dream.html "Hello world!")
