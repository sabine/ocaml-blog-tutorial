# Let's Write a Simple Blog in OCaml

This repository contains a tutorial suitable for use in a workshop format.

The goal of writing a blog website is broken down into discrete tasks with respective possible solutions.

On every step, the file [TASK.md](TASK.md) contains explanations, instructions, as well as some hints on what to do next.

## What exactly are we building?

A blog is a website that displays long-form posts on specific topics, keywords, or sources.

The individual posts will be presented in a single, easy-to-read feed.

# Outline 

## I. Introduction (5 minutes)

### 1. Briefly introduce speakers and their experience with OCaml
### 2. Introduce the topic of the talk and its relevance to the audience

## II. What is Functional Programming? (15 minutes)

See [Functional Programming](./functionnal_programming.md)

## III. Setup your environment (15 minutes)

Clone the repository, use dev container. Open the terminal, and UTop!

Clone https://github.com/sabine/ocaml-blog-tutorial.
Install the dev container VSCode extension: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers.

CTRL+SHIFT+P "Dev Containers: Open Folder in Container"

## IV. A Tour of OCaml (1 hour)

Open https://staging.ocaml.org/docs/a-tour-of-ocaml and go through it.

## V. Web Development in OCaml (1 hour)

- 1st hour
  - 15min - fp_examples.ml
  - 45min - Tour of OCaml with utop in the dev container - 
- 2nd hour: starting from the hello world example in this repo, we build a very simple blog
  - break 15min
  - run the hello world example
  - do step by step project from the folders
- 3rd hour:
  - represent the blog post as OCaml datatype
  - load the blog post from a markdown file
  - render a HTML template that lists all blog posts


TODO: make playgrounds for the Tour of OCaml