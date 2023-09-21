(*
  Step 3 - Introducing Routes

  dune exec solution3
*)

let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (Template.render "world"));
         Dream.get "**" (fun _ -> Dream.html ~code:404 "404 Not Found");
       ]
