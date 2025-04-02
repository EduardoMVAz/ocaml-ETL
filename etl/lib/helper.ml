(** Function created to parse the status, 
returning the status itself if it matches any of the avaiable options, 
  and failing if not. *)
let parse_status status = 
  match status with 
  | "Completed" -> status
  | "Pending" -> status
  | "Cancelled" -> status
  | _ -> failwith "Status must be Completed, Pending or Cancelled." ;;

(** Function created to parse the origin, 
returning the origin itself if it matches any of the avaiable options, 
  and failing if not. *)
let parse_origin origin = 
  match origin with
  | "O" -> origin
  | "P" -> origin
  | _ -> failwith "Origin must O (Online) or P (Physical)." ;;

(** Function created to transform the order_with_item records into the output csv file. 
The headers are merged into a list together with the order_with_item records parsed into string.
*)
let parse_to_csv summarized_orders =
  ["order_id"; "total_amount"; "total_taxes"] ::
  List.map (fun (order_id, total_amount, total_taxes) ->
      [
        string_of_int order_id;
        Printf.sprintf "%.2f" total_amount;
        Printf.sprintf "%.2f" total_taxes
      ]
    ) summarized_orders
  
(** Function that rounds floats to 2 decimal houses, used for insertion in the sqlite database. *)
let round_2 f =
  Float.round (f *. 100.) /. 100.

(** Function that formats all floats from the summarized orders for insertion in the sqlite database. *)
let rec parse_floats summarized_orders = 
  match summarized_orders with
  | [] -> []
  | (id, amount, taxes) :: t -> 
    let rounded = (id, round_2 amount, round_2 taxes) in
    rounded :: parse_floats t