


module type Glsl_base =
  sig
  type 'a expr
  val float : float -> float expr
  val int   : int   -> int   expr

  type 'a ref
  
  type 'a stmt
  val ( := ) : 'a ref -> 'a expr -> unit stmt
  val ( >>= ) : unit stmt -> unit stmt -> unit stmt

  type 'a topdecl

  module In : sig
  end

  module Out : sig
  end

  type 'a _type
  val void : unit _type

  type funcname
  val main : funcname

  val func0 : 'a _type -> funcname -> (unit -> 'a stmt) ->
    (unit -> unit) ref topdecl

  val ( >>=+ ) : 'a ref topdecl -> ('a ref -> 'b ref topdecl) -> 'b ref topdecl
  val ( let+ ) : 'a ref topdecl -> ('a ref -> 'b ref topdecl) -> 'b ref topdecl
  val top__return : 'a -> 'a ref topdecl

  type 'a dir
  val ( #! ) : 'a. 'a dir -> 'a
  type vers
  type profile
  val version : (vers -> profile -> unit ref topdecl) dir
  val v3_3_0 : vers
  val core   : profile

  val ( ! ) : 'a ref -> 'a expr

  type 'a prog
  val prog : 'a ref topdecl -> 'a prog

  end

type vec2 = float * float
type vec3 = float * float * float
type vec4 = float * float * float * float

module type Glsl =
  sig

  include Glsl_base

  module In : sig
    include (module type of In)
    val ref__vec2 : ?layout__location:int -> unit -> (vec2 ref topdecl)
    val ref__vec3 : ?layout__location:int -> unit -> (vec3 ref topdecl)
  end

  module Out : sig
    include (module type of Out)
    val ref__vec4 : ?layout__location:int -> unit -> (vec4 ref topdecl)
  end

  module Vec4 : sig
    val of_vec3 : vec3 expr -> float expr -> vec4 expr
    val make : float expr -> float expr -> float expr -> float expr -> vec4 expr
  end

  end

module Glsl__opengl (C : Glsl) =
  struct open C module type S = sig

  module Gl : sig
    val position : vec4 ref
  end

  end end
