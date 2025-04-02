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

(** Function that rounds floats to 2 decimal houses, used for insertion in the sqlite database. *)
val round_2 : float -> float

(** Function that formats all floats from the summarized orders for insertion in the sqlite database. *)
val parse_floats : (int * float * float) list -> (int * float * float) list