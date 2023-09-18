(*
   Step 3 - Render the list of posts

   There is now a new file `posts.ml` that contains some example blog posts.

   Task -- update the template to render the list of blog posts `Posts.posts`
*)

let () =
  Dream.run
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html (Template.render Post.posts)) ]
