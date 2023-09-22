(*
  Step 4 - Render a list of posts

  dune exec solution4
*)

let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (Template.home Post.all));
         Dream.get "**" (fun _ -> Dream.html ~code:404 "404 Not Found");
       ]
