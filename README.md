# Let's Write a Simple Blog in OCaml

Welcome to this tutorial on writing a simple blog in OCaml.

This tutorial and the content of this repository are resources for a workshop at Ada tech school the 22nd of September.

Before attending the workshop or going through the tutorial, please make sure you're all set by going through the Setup Your Environment section below.

Once you're all set, you can start by reading the [Tour of OCaml](https://staging.ocaml.org/docs/a-tour-of-ocaml) on the official documentation, and read the accompanying [Functional Programming guide](./functionnal_programming.md), and move on with the tutorial below. 

## Setup Your Environment

We're going to use Dev Containers for this workshop.

To use them, you'll need a few things:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [The Dev Containers VSCode extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

If you're unsure how to install any of these, have a look a the [Developing inside a Container] guide from the VSCode documentation: the Getting Started section should guide you through the installation of all of the above.

Once you have VSCode and the Dev Containers extension installed, you can open this repository inside a Dev Containers.

First, clone the Git repository locally:

```
git clone https://github.com/sabine/ocaml-blog-tutorial.git
```

Start VSCode, and run the "Dev Containers: Open Folder in Container" command from the command palette, and select the `ocaml-blog-tutorial` folder you've just cloned.

It should take a few minutes to install the dependencies the first time you open the project.

You can test that everything is working by running the following in VSCode's terminal:

```
dune exec src/main.exe
```

If it prints "Hello World!", you're all set!
