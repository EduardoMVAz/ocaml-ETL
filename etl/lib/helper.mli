(** Function created to parse the status, 
returning the status itself if it matches any of the avaiable options, 
  and failing if not. *)
val parse_status : string -> string

(** Function created to parse the origin, 
returning the origin itself if it matches any of the avaiable options, 
  and failing if not. *)
val parse_origin : string -> string

(** Function created to transform the order_with_item records into the output csv file. *)
val parse_to_csv : (int * float * float) list -> string list list