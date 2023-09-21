(*
  Step 6 - Make it pretty with CSS

  dune exec solution6
*)

let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (Template.all_posts Post.all));
         Dream.get "/post/:slug" (fun request ->
             let slug = Dream.param request "slug" in
             let post = List.find (fun p -> p.Post.slug = slug) Post.all in
             Dream.html (Template.post post));
         Dream.get "/static/**" @@ Dream.static "static";
         Dream.get "**" (fun _ -> Dream.html ~code:404 "404 Not Found");
       ]
