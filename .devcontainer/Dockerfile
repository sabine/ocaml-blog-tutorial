FROM ocaml/opam:debian-ocaml-5.0

# Branch freeze was opam-repo HEAD at the time of commit
RUN cd opam-repository && git pull origin 0dbeadf469d05bd0d2973840046689a24abcc319 && opam update

# Dev tools
RUN opam install -y merlin ocamlformat=0.26.0 utop ocaml-lsp-server

# Deps
RUN sudo apt update && sudo apt install -y pkg-config libev-dev libgmp-dev libonig-dev libssl-dev
