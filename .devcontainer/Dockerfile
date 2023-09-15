FROM ocaml/opam:debian-ocaml-5.1

# Dev tools
RUN opam install -y merlin ocamlformat=0.26.0 utop ocaml-lsp-server

# Deps
RUN sudo apt update && sudo apt install -y pkg-config libev-dev libgmp-dev libonig-dev libssl-dev
