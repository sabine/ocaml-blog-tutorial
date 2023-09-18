let () =
  Dream.run
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html (Template.render "world")) ]
