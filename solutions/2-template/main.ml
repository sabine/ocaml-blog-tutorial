(*
  Step 2 - Let's use a HTML template!

  Tasks
  1. Create a new file template.eml.html with this content:

  let render param =
    <html>
    <body>
      <h1>Hello <%s param %>! This is a HTML Template.</h1>
    </body>
    </html>

  2. Add this code to the dune file:

  (rule
   (targets template.ml)
   (deps template.eml.html)
   (action
    (run %{bin:dream_eml} %{deps} --workspace %{workspace_root})))

  3. Change this file by replacing the string "Hello world!" with

  (Template.render "world")

  to use our new template.

  4. Run the code and check in your browser that the HTML template
     is returned under https://localhost:8080
*)

let () = Dream.run (fun _ -> Dream.html (Template.render "world"))
