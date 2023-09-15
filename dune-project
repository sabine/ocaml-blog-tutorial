(lang dune 2.0)

(generate_opam_files)

(package
 (name myblog)
 (maintainers "no one")
 (synopsis "simple blog")
 (depends 
 dune
 (ocaml)
 (ocamlformat (= 0.26.0))
 (dream
   (= 1.0.0~alpha5))))