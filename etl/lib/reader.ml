open Sqlite3 ;;

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
  
(** 
--- CHATGPT ASSISTED ---
Functions for writing the output into a sqlite3 db.
*)
let create_table db =
  let query = "
    CREATE TABLE IF NOT EXISTS order_summary (
      order_id INTEGER PRIMARY KEY,
      total_amount REAL,
      total_taxes REAL
    )
  " in
  match Sqlite3.exec db query with
  | Rc.OK -> ()
  | rc -> failwith ("SQLite error: " ^ Rc.to_string rc)
  
let insert_summary db (order_id, total_amount, total_taxes) =
  let stmt = Sqlite3.prepare db
    "INSERT INTO order_summary (order_id, total_amount, total_taxes) VALUES (?, ?, ?)"
  in
  ignore (Sqlite3.bind stmt 1 (Data.INT (Int64.of_int order_id)));
  ignore (Sqlite3.bind stmt 2 (Data.FLOAT total_amount));
  ignore (Sqlite3.bind stmt 3 (Data.FLOAT total_taxes));
  match Sqlite3.step stmt with
  | Rc.DONE -> ignore (Sqlite3.finalize stmt)
  | rc -> failwith ("SQLite insert error: " ^ Rc.to_string rc)

let save_all_to_db db summaries =
  List.iter (insert_summary db) summaries
  