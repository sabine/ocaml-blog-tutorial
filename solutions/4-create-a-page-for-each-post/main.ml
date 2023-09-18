(*
   Step 4 - Create a new template to render the individual post

   Tasks
   1. Create a new function `Template.post` that renders the blog post
   2. Instead of returning the `slug` parameter from the "/post/:slug" route, look up the post and render the new Template.
     a - use the function List.find
*)

let () =
  Dream.run
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (Template.render Post.posts));
         Dream.get "/post/:slug" (fun request ->
             let slug = Dream.param request "slug" in
             let post = List.find (fun p -> p.Post.slug = slug) Post.posts in
             Dream.html (Template.post post));
       ]
