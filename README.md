# Oglsl

Oglsl is a set of OCaml module signatures providing overloadable functions and operators and abstract types for writing GLSL [^wiki-glsl] in OCaml. In other words, it is a tagless-final [^jfp] eDSL - abstract algebra of GLSL embedded in OCaml.

Oglsl isn't useful on its own. (TBA)

## Example

An [introduction to Oglsl][tutorial] is available at the wiki. For a use case of Oglsl in one short snippet, here it is:

```ocaml
module SHADER
(C: Oglsl.Glsl)
(C_stdlib: Oglsl.Glsl__opengl(C).S) = struct
  open C
  open C_stdlib

  let vertex_shader =
    prog begin
    (#!) version v3_3_0 core >>=+ fun _ ->
    let+ pos = In.ref__vec3 ~layout__location:0 () in
    func0 void main @@ fun () ->
      Gl.position := Vec4.of_vec3 !pos (float 1.0)
    end
end
```
which translates to (assuming we provide an interpreter implementation):
```glsl
#version 330 core
layout(location = 0) in vec3 pos;
void main() {
  gl_Position = vec4(pos, 1.0);
}
```
Let's dissect what's going on:

- TBA
- TBA

[^wiki-glsl]: https://en.wikipedia.org/wiki/OpenGL_Shading_Language

[^jfp]: https://okmij.org/ftp/tagless-final/

[tutorial]: https://tba
