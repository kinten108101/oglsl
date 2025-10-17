(lang dune 3.20)

(name oglsl)
(version 0.1.0)

(generate_opam_files true)

(source
 (github kinten108101/oglsl))

(authors "Kinten Le <kinten108101@protonmail.com>")

(maintainers "Kinten Le <kinten108101@protonmail.com>")

(license MIT)

(documentation https://github.com/kinten108101/oglsl/wiki)

(package
 (name oglsl)
 (synopsis "Embedding GLSL in OCaml")
 (description "Oglsl is a set of module signatures providing overloadable functions and operators and abstract types for writing GLSL in OCaml. In other words, it is a tagless-final eDSL - abstract algebra of GLSL embedded in OCaml.")
 (depends ocaml)
 (tags
  (tagless-final opengl glsl edsl)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
