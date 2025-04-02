(** 
--- CHATGPT ASSISTED ---
Functions used for reading a csv file from the internet.
*)
let fetch url =
  let uri = (Uri.of_string url) in
  let (_, body) = Lwt_main.run (Cohttp_lwt_unix.Client.get uri) in
  let body_str = Lwt_main.run (Cohttp_lwt.Body.to_string body) in
  body_str ;;

let read_csv_url url =
  let raw_data = fetch url in
  let data = Csv.of_string raw_data |> Csv.input_all in
  data ;;

(** 
--- CHATGPT ASSISTED ---
Function that writes the parsed output into a csv file.
*)
let write_order_total_csv path csv_parsed_orders =
  let file = Csv.to_channel (open_out path) in
  Csv.output_all file csv_parsed_orders;
  Csv.close_out file;
  () ;;
  