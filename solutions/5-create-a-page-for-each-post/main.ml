(*
  Step 4 - Create a new template to render an individual post

  Tasks
  1. Create a new function `Template.post` that renders the blog post
    a - in the template, you can use <%s! ... %> to render the html_body of the post.
        s! tells the template that the OCaml expression in this block is a string and
        that it should not be HTML-escaped. One must only use this raw string tag
        on sanitized HTML - otherwise, an [XSS attack](https://owasp.org/www-community/attacks/xss/)
        is possible.
   
  2. Look up the post using the :slug parameter of the new route and render the new Template.
    a - use the function List.find : (Post.t -> bool) -> Post.t list -> Post.t.
        List.find takes a predicate (a function returning true or false)
        that should be true for the item we're looking for.

        Look up the post that has the same slug as the route parameter "slug".
     
    b - modify Template.all_posts to render, for every blog post,
        an <a> tag that links to the new route.
*)

let () =
  Dream.run
  @@ Dream.router
       [
         Dream.get "/" (fun _ -> Dream.html (Template.all_posts Post.all));
         Dream.get "/post/:slug" (fun request ->
             let slug = Dream.param request "slug" in
             let post = List.find (fun p -> p.Post.slug = slug) Post.all in
             Dream.html (Template.post post));
       ]
