let parse_string_to_ptime value = 
  match Ptime.of_rfc3339 value with
  | Ok (ptime, _, _) -> ptime
  | Error _ -> failwith "Invalid datetime"

let parse_status status = 
  match status with 
  | "Completed" -> status
  | "Pending" -> status
  | "Cancelled" -> status
  | _ -> failwith "Status must be Completed, Pending or Cancelled." ;;

let parse_origin origin = 
  match origin with
  | "O" -> origin
  | "P" -> origin
  | _ -> failwith "Origin must O (Online) or P (Physical)." ;;