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

We've prepared a working directory in `src/` it already contains an OCaml module, and a dune file that declares an executable. This is where you will be writing your code in.

When learning in a self-directed fashion, you can check the solutions in the `solutions/` directory after you completed the corresponding step, or when you get too stuck to continue. However, when you get stuck, we'd be happy if you open an issue on this repository with your question, so we can clarify and improve the tutorial.

At any point, when you see a squiggly red underline saying that a module is not defined, you can run

```shell
dune build
```

or

```shell
dune exec main
```

to tell the build system Dune to build all the files, so that the editor plugin can pick up the type information to display.

### Step 1: Hello World

To write our web application, we'll use [Dream](https://github.com/aantron/dream), OCaml's web framework.

Dream exposes all of its functions in its toplevel `Dream` module. To run a Dream application, you can call the [`Dream.run`](https://aantron.github.io/dream/#val-run) function. It only has one non-optional argument: a Handler.

In Dream, a [Handler](https://aantron.github.io/dream/#type-handler) is a function that takes a `Dream.request` as input, and returns a `Dream.response`. If you've worked with other web frameworks, you might have come across the term "Controller". It's essentially the same thing.

**Tasks:**

1. Update `main.ml` to implement a Dream application that always returns "Hello World!". You can replace the `print_endline "Hello World"` with this call to the `Dream.run` function:

```ocaml
Dream.run (fun _ -> Dream.html "Hello world!")
```

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

```ocaml
let render param =
  <html>
    <body>
      <h1>Hello <%s param %>! This is a HTML Template.</h1>
    </body>
  </html>
```

2. Add this code to the `dune` file:

```s
(rule
 (targets template.ml)
 (deps template.eml.html)
 (action
  (run %{bin:dream_eml} %{deps} --workspace %{workspace_root})))
```

This runs `dream_eml` on the `template.eml.html` template to generate the corresponding `template.ml` OCaml file.

The function `render` from `template.eml.html` can now be used in your program like this: `Template.render`.

3. Change `main.ml` by replacing the string "Hello world!" with

```ocaml
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

```ocaml
Dream.get "**" (fun _ -> Dream.html ~code:404 "404 Not Found")
```

at the end of the list of routes to to register a handler that returns a 404 response. Here, `**` is a wildcard that matches and URL. Since routes are matched from top to bottom, this handler will only be called if none of the other routes matched.

3. Run the code and check in your browser that http://localhost:8080 shows the "hello world" template,
and http://localhost:8080/abc gives a 404 response.

### Step 4: Render a list of posts

Since we're creating a blog website, it's now a good time to work with some data that we want to display in our templates.

For now, we'll represent a blog post as a struct that has fields for the blog posts `title` and `html_body`, as well as a `slug` field which we will use to refer to the blog post in a URL.

**Tasks:**

1. Create a new file `post.ml` in the same directory as `main.ml` with the following content:

```ocaml
type t = { title : string; slug : string; html_body : string; image : string }

let all =
  [
    {
      title = "Hello I am the first post!";
      slug = "hello";
      html_body = "<p>I just wanted to say hi!</p>";
      image = "computer-4484282_1280.jpg";
    };
    {
      title = "It's a nice day";
      slug = "nice-day";
      html_body = "<p>Don't you think so, too?</p>";
      image = "man-791049_1280.jpg";
    };
    {
      title = "Hello I am the third post!";
      slug = "third-post";
      html_body = "<p>See you later!</p>";
      image = "work-3938876_1280.jpg";
    };
  ]
```

This is, for now, a list of blog posts that have a `title`, a `slug`, a `html_body`, and an `image`.

Now, `Post.t` is a type that represents a single blog post, and `Post.all : t list` is the list of all blog posts.

2. Rename the `render` function in `template.eml.html` to `all_posts` and change the HTML template to render a list of blog posts.

Instead of taking a `param` parameter, the new `all_posts` function takes a parameter `(posts: Post.t list)`.

Instead of showing `Hello <%s param %>! This is a HTML Template.`, you can iterate over the list of posts using the `List.iter` function like this:

```ocaml
    <% posts |> List.iter (fun (p: Post.t) -> %>
        ... TODO: write HTML here ...
    <% ); %>
```
Render a `<ul>` and iterate over the list to render a `<li>` tag that contains the title of the blog post.

Hint: <%s ... %> is used to render an OCaml string.

1. Run the code and check in your browser that http://localhost:8080 shows list of blog posts

### Step 5: Subpage for individual posts

All we did in the last step was render a list of titles of the blog posts, but now we want to give every blog post its own HTML page under the URL `/post/:slug`, where `:slug` is the value of the `slug` field of the particular blog post. This would allow people to link to or bookmark a specific blog post.

We will need a new template for the 

**Tasks:**

1. Create a new function `post` in `template.eml.html` that takes a parameter `(post: Post.t)` and renders the following template:

```ocaml
let post (post : Post.t) =
  <html>
    <body>
      <a href="/">all posts</a>
      ...
    </body>
  </html>
```

In the template (where `...` is), use `<%s ... %>` to render the `title` of the post inside an `<h1>` tag, and use `<%s! ... %>` to render the `html_body` of the post as raw HTML.

`s!` means that the OCaml expression in this block is a string that should be placed into the template without escaping special characters like `<`, `>`, and more. One must only use this raw string tag on sanitized HTML - otherwise, an [XSS attack](https://owasp.org/www-community/attacks/xss/) is possible.

2. Create a new route for the URL `/post/:slug` and read the `"slug"` parameter from the request using `Dream.param`.

See an example here: https://aantron.github.io/dream/#routing

3. Look up the post using the `slug` and render the new Template.

To find the post, use the function `List.find : (Post.t -> bool) -> Post.t list -> Post.t`.

`List.find` takes a predicate (a function returning `true` or `false`) that should be `true` for the item we're looking for.

Notice that, when the blog post does not exist, we get an error.

3a. (optional) To avoid that, you can use `List.find_opt : (Post.t -> bool) -> Post.t list -> Post.t option` instead, and you can use

```ocaml
match post with
| Some p -> ...
| None -> ...
```

to render `Template.post` when a post was found, and return a 404 response when no post with the given slug was found.

4. Modify `Template.all_posts` so that every blog post has an `<a>` tag around the title that links to the new route.

You will need to use `<%s ... %>` again to render `post.slug` as part of the URL.

5. Run the code and check in your browser that http://localhost:8080 shows the list of blog posts and that you can follow the link to an individual blog post's page and from there back to http://localhost:8080.

### Step 6 - Making it pretty - serving files

So far, we're serving naked, unstyles HTML pages. Let's change that and add some CSS.

There already is a folder `static` in this directory that contains a CSS stylesheet, as well as the images belonging to the posts.

**Tasks:**

1. Serve the files from the `static` directory under the route `/static/**`.

See https://aantron.github.io/dream/#static-files for an example of how to do this.

2. Modify the templates in `template.eml.html` and add a HTML `<head>` tag that contains the `<link>` tag for the stylesheet:

```ocaml
<link rel="stylesheet" href="/static/chota.min.css">
```

3. Add a `<div class="container">` right inside the body of both templates, to wrap the existing elements.

3a. (optional) Having the basic structure / layout of the page repeated in every template is repetitive. Can you see how to move the `<html>, <head>, <link>, <body>, <div class="container">` to a separate function that can be used by both the `post` and the `all_posts` template?

Hint: You can create a `layout` function that takes a string parameter `inner_html` and renders it inside the template with `<%s! inner_html %>`.

Hint 2: It is possible to pass a HTML template to the `layout` function like this:

```ocaml
let all_posts =
    layout (
        <h1>All Posts</h1>
        ...
    )
```

4. Add an `<img src="...">` tag to the `post` template in `template.eml.html` to show `post.image`.

5. Look at how much nicer it looks now.

### Wrapping up for now

There's a lot further we can take this from here. Ideas:

1. Load blog posts from Markdown files (with YAML headers) instead
2. Load blog posts from a database instead
3. Add more fields like `author`, `date_published`, etc.
4. Add TailwindCSS to the project
5. Create a RSS feed that lists all the blog posts, for RSS readers to subscribe to

If you're interested in this, or have other ideas where to go with this tutorial, open an issue on the github repo.