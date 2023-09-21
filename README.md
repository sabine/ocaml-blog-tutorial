# Building a Simple Blog with OCaml: Workshop Guide

Welcome to the OCaml blog creation workshop, brought to you in association with [Ada Tech School](https://adatechschool.fr/)! In this workshop, scheduled for the 22nd of September, 2023, we'll guide you step-by-step as you build a simple blog using OCaml.

Before you dive into the tutorial, ensure your environment is correctly set up by following the guide below. We also recommend acquainting yourself with OCaml through the recommended readings.

## Pre-Workshop Preparations

### 1. Set Up Your Environment

To provide a seamless workshop experience, we'll be using Dev Containers. To get started, install the following software:

- **Docker Desktop**: [Download here](https://www.docker.com/products/docker-desktop/)
- **Visual Studio Code (VSCode)**: [Download here](https://code.visualstudio.com/)
- **Dev Containers VSCode Extension**: [Download here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

If you encounter any issues while installing the applications above, consult the [Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers) guide from the VSCode documentation.

#### On Windows

```
net localgroup docker-users "your-user-id" /ADD
```

### 2. Clone the Workshop Repository

Once you have VSCode and the Dev Containers extension ready, clone the workshop repository to your local machine using the following command:

```sh
git clone https://github.com/sabine/ocaml-blog-tutorial.git
```

### 3. Open the Project in Dev Containers

Launch VSCode and execute the "Dev Containers: Open Folder in Container" command from the command palette. Select the `ocaml-blog-tutorial` folder that you cloned in the previous step.

Initializing the environment for the first time might take a few minutes, as it involves installing necessary dependencies.

### 4. Verify Your Setup

To ensure everything is set up correctly, run the following command in the VSCode terminal (Terminal > New Terminal):

```sh
dune exec main
```

When you see the "Hello World!" message printed in the terminal, your setup is successful!

## Recommended Readings

Before attending the workshop, familiarize yourself with OCaml through the following resources:

- **[About OCaml](https://ocaml.org/about)**: A high-level introduction to the OCaml language and why you might want to use it.
- **[A Tour of OCaml](https://staging.ocaml.org/docs/a-tour-of-ocaml)**: Dive into the official OCaml documentation to understand the core concepts of the language. No need to be thorough since we'll cover this during the workshop, but you might want to skim through to prepare questions.

## Ready to Start

You are now all set for the workshop! Keep an eye on this repository for the tutorial, which we will delve into during the workshop session.

We look forward to building together with you at the Ada Tech School on the 22nd of September, 2023.

## Tutorial

We've prepared a working directory in `src/` it already contains an OCaml module, and a dune file that declares an executable.

### Step 1: Hello World

To write our web application, we'll use [Dream](https://github.com/aantron/dream), OCaml's web framework.

Dream exposes all of its functions in its toplevel `Dream` module. To run a Dream application, you can call the [`Dream.run`](https://aantron.github.io/dream/#val-run) function. It only has one non-optional argument: a Handler.

In Dream, a [Handler](https://aantron.github.io/dream/#type-handler) is a function that takes a `Dream.request` as input, and returns a `Dream.response`. If you've worked with other web frameworks, you might have come across the term "Controller". It's essentially the same thing.

Here's an example of a handler:

```ocaml
let my_handler _req =
    Dream.html "Good morning, world!"
```

**Tasks:**

1. Update `main.ml` to implement a Dream application that always returns "Hello World!".

2. In your terminal inside the dev container, run

```shell
dune exec main
```

3. open http://localhost:8080 in your browser to confirm that "Hello world!" is shown.

### Step 2: Sending HTML

Generally, a website consists of HTML pages and a common practice is to render HTML pages from templates:

Template files are processed to turn them into functions that may take some parameters and return a string that contains the rendered HTML.

Dream supports different HTML template engines. The one we're going to use is the default one. Every `.eml.html` template is translated using the `dream_eml` command to an OCaml file that provides the functions that render the HTML fragments defined in the corresponding `.eml.html` template.

**Tasks:**

1. Create a new file `template.eml.html` in the same folder as `main.ml` with this content:

```
let render param =
  <html>
    <body>
      <h1>Hello <%s param %>! This is a HTML Template.</h1>
    </body>
  </html>
```

2. Add this code to the dune file:

```
(rule
 (targets template.ml)
 (deps template.eml.html)
 (action
  (run %{bin:dream_eml} %{deps} --workspace %{workspace_root})))
```

This runs `dream_eml` on the `template.eml.html` template to generate the corresponding `template.ml` OCaml file.

The function `render` from `template.eml.html` can now be used in your program like this: `Template.render`.

3. Change `main.ml` by replacing the string "Hello world!" with

```
(Template.render "world")
```

to use the new template.

4. Run the code and check in your browser that the HTML template is returned under https://localhost:8080

### Step 3: Introducing routes

So far, our web server returns the same HTML page for every request, independent of the URL. Generally, a web server serves different HTML pages under different URLs. So let's introduce different routes

**Tasks:**

1. Use the `Dream.logger` middleware so that you can see the request log in your terminal when HTTP requests are processed by your Dream web server.

Here is an example of how `Dream.logger` is used: https://github.com/aantron/dream/tree/master/example/2-middleware#files

2. Serve the template only under the `"/"` URL using the HTTP Get method and make all other routes return a 404 response.

Hint: look at https://github.com/aantron/dream/tree/master/example/3-router#files and use `Dream.router` and `Dream.get` to serve the HTML template.

You can use

```Dream.get "**" (fun _ -> Dream.html ~code:404 "404 Not Found")```

at the end of the list of routes to to register a handler that returns a 404 response. Here, `**` is a wildcard that matches and URL. Since routes are matched from top to bottom, this handler will only be called if none of the other routes matched.

3. Run the code and check in your browser that http://localhost:8080 shows the "hello world" template,
and http://localhost:8080/abc gives a 404 response.

### Step 4: Render a list of posts

Since we're creating a blog website, it's now a good time to work with some data that we want to display in our templates.

For now, we'll represent a blog post as a struct that has fields for the blog posts `title` and `html_body`, as well as a `slug` field which we will use to refer to the blog post in a URL.

**Tasks:**

1. Create a new file `post.ml` in the same directory as `main.ml` with the following content:

```
type t = { title : string; slug : string; html_body : string }

let all =
  [
    {
      title = "Hello I am the first post!";
      slug = "hello";
      html_body = "<p>I just wanted to say hi!</p>";
    };
    {
      title = "It's a nice day";
      slug = "nice-day";
      html_body = "<p>Don't you think so, too?</p>";
    };
    {
      title = "Hello I am the third post!";
      slug = "third-post";
      html_body = "<p>See you later!</p>";
    };
  ]
```

This is, for now, a list of blog posts that have a `title`, a `slug` and a `html_body`.

Now, `Post.t` is a type that represents a single blog post, and `Post.all : t list` is the list of all blog posts.

2. Rename the `render` function in `template.eml.html` to `all_posts` and change the HTML template to render a list of blog posts.

You can iterate over the list of posts using the `List.iter` function like this:

```
    <% posts |> List.iter (fun (p: Post.t) -> %>
        ... TODO: write HTML here ...
    <% ); %>
```

Render a `<ul>` and iterate over the list to render a `<li>` tag that contains the title of the blog post.

Hint: <%s ... %> is used to render an OCaml string.

### Step 5: Subpage for individual posts

All we did in the last step was render a list of titles of the blog posts, but now we want to give every blog post its own HTML page under the URL `/post/:slug`. This would allow people to link to or bookmark a specific blog post.

We will need a new template for the 

**Tasks:**

1. Create a new function `Template.post` that renders the blog post

In the template, you can use `<%s! ... %>` to render the `html_body` of the post as raw HTML.
`s!` means that the OCaml expression in this block is a string that should be placed into the template without escaping special characters like `<`, `>`, and more. One must only use this raw string tag on sanitized HTML - otherwise, an [XSS attack](https://owasp.org/www-community/attacks/xss/) is possible.

2. Create a new function `post` in `template.eml.html` that takes a parameter `(post: Post.t)` and renders the following template:

```
let post (post : Post.t) =
  <html>
    <body>
      <a href="/">all posts</a>
      <h1><%s post.title %></h1>
      <div>
        <%s! post.html_body %>
      </div>
    </body>
  </html>
```

3. Create a new route for the URL `/post/:slug` and read the `"slug"` parameter from the request using `Dream.param`.

See an example here: https://aantron.github.io/dream/#routing

4. Look up the post using the `slug` and render the new Template.

To find the post, use the function `List.find : (Post.t -> bool) -> Post.t list -> Post.t`.

`List.find` takes a predicate (a function returning `true` or `false`) that should be `true` for the item we're looking for.

5. Modify `Template.all_posts` so that every blog post has an `<a>` tag around the title that links to the new route.

You will need to use `<%s ... %>` again to render `post.slug` as part of the URL.