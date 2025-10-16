type _ kref = { content: string; name: string } and _ klet = { content: string }


module Glsl_base (Naming : (module type of Naming.M())) =
  struct
  type _ expr = string
  let float = Stdlib.string_of_float
  let int   = Stdlib.string_of_int

  type 'a ref = 'a kref

  type _ stmt = string
  let ( := ) xref y = let { name = xref'; content } = xref in xref' ^ " = " ^ y ^ ";"
  let ( >>= ) x y = x ^ " " ^ y

  type 'a topdecl = 'a

  module In = struct
  end

  module Out = struct
  end

  type _ _type = string
  let void = "void"

  type funcname = string
  let main = "main"

  let func0 _type funcname f =
    let fdef = f () in { content = _type ^ " " ^ funcname ^ "(){ " ^ fdef ^ " }" ; name = funcname }

  let ( >>=+ ) x binder = let y = binder x in { y with content = x.content ^ "\n" ^ y.content }
  let ( let+ ) = ( >>=+ )
  let top__return _ = { content = "" ; name = "" }

  type 'a dir = 'a
  let ( #! ) f = f
  type vers = string
  type profile = string
  let version v profile = { content = "#version " ^ v ^ " " ^ profile; name = "" }
  let v3_3_0 = "330"
  let core   = "core"

  let ( ! ) (xref : _ ref) = xref.name

  type _ prog = string
  let prog = function { content ; name = _ } -> content

  end


let make_layout ?layout__location str_later = let layout__location = layout__location |> Option.map (fun x -> "location", string_of_int x) in [layout__location] |> List.filter_map (function None -> None | Some x -> Some x) |> function [] -> str_later | xs -> xs |> List.map (fun (key, valuestr) -> key ^ " = " ^ valuestr) |> String.concat ", " |> fun x -> "layout(" ^ x ^ ") " ^ str_later

module Glsl (Naming : (module type of Naming.M())) =
  struct

  include Glsl_base(Naming)

  module In = struct
    include In
    let ref__vec2 ?layout__location () = let name = Naming.make () in let content = make_layout ?layout__location ("in vec2 " ^ name ^ ";") in { content; name }
    let ref__vec3 ?layout__location () = let name = Naming.make () in let content = make_layout ?layout__location ("in vec3 " ^ name ^ ";") in { content; name }
  end

  module Out = struct
    include Out
    let ref__vec4 ?layout__location () = let name = Naming.make () in let content = make_layout ?layout__location ("out vec4 " ^ name ^ ";") in { content; name }
  end

  module Vec4 = struct
    let of_vec3 i_j_k w = "vec4(" ^ i_j_k ^ ", " ^ w ^ ")"
    let make i j k w = "vec4(" ^ i ^ ", " ^ j ^ ", " ^ k ^ ", " ^ w ^ ")"
  end

  end

module Glsl__opengl = struct
  module Gl = struct
    let position = { name = "gl_Position"; content = "" }
  end
end
