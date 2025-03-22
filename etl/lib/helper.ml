let parse_string_to_int value = 
  int_of_string value ;;

let parse_string_to_float value = 
  float_of_string value ;;

let parse_string_to_ptime value = 
  match Ptime.of_rfc3339 value with
  | Ok (ptime, _, _) -> ptime
  | Error _ -> failwith "Invalid datetime"