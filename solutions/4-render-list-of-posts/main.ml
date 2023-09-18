(*
  Step 3 - Render the list of posts

  There is now a new file `posts.ml` that contains some example blog posts.

  Tasks
  1. update the all_posts template to render a list of blog posts.
    a - iterate over the list of posts like this:

        <% posts |> List.iter (fun (p: Post.t) -> %>
          ... TODO: write more HTML here ...
        <% ); %>

    b - in the body of the List.iter, render a <li> tag
        that contains the title of the blog post.

        Remember: <%s ... %> is used to render an OCaml string.
*)

let () =
  Dream.run
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html (Template.all_posts Post.all)) ]
