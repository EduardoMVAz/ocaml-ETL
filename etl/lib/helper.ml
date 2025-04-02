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
  