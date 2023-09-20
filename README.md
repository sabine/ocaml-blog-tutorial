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
