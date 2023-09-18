(*
  Step 3 - Introducing Routes

  Tasks
  1. Serve the template only under the "/" URL using the HTTP Get method and make
     all other routes return a 404 response.

    a - look at https://github.com/aantron/dream/tree/master/example/3-router#files
        and use Dream.router and Dream.get to serve the HTML template.

    b - add Dream.logger as well in order to see the request log in your terminal
        as HTTP requests are processed by your Dream web server.

    c - run the code and check in your browser that http://localhost:8080 shows
        the template, and http://localhost:8080/abc returns a 404 response.
*)

let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html (Template.render "world")) ]
