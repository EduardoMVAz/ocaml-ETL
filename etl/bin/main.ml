open Etl.Reader ;;
open Etl.Mapper ;;
open Etl.Helper ;;
open Etl.Transformer ;;

let get_cli_arguments () =
  match Array.length Sys.argv with
  | 1 ->
      print_endline "No filters applied!\n";
      ("", "")  (* No filters *)
  | 3 ->
      if Sys.argv.(1) = "--s" then
        let status = parse_status Sys.argv.(2) in
        Printf.printf "Filtering only by status: %s\n" status;
        (status, "")
      else if Sys.argv.(1) = "--o" then
        let origin = parse_origin Sys.argv.(2) in
        Printf.printf "Filtering only by origin: %s\n" origin;
        ("", origin)
      else (
        prerr_endline "Expected --s or --o as first argument.\n";
        exit 1
      )
  | 5 ->
      if Sys.argv.(1) = "--s" && Sys.argv.(3) = "--o" then
        let status = parse_status Sys.argv.(2) in
        let origin = parse_origin Sys.argv.(4) in
        Printf.printf "Filtering by status and origin: %s and %s\n" status origin;
        (status, origin)
      else (
        prerr_endline "Expected --s <status> --o <origin>\n";
        exit 1
      )
  | _ ->
      prerr_endline "CORRECT USAGE:\n  dune exec bin/main.exe -- --s <status> --o <origin>\n";
      exit 1

let () =
  let order_data = read_csv_url "https://raw.githubusercontent.com/EduardoMVAz/ocaml-ETL/refs/heads/main/etl/data/order.csv" in
  let order_item_data = read_csv_url "https://raw.githubusercontent.com/EduardoMVAz/ocaml-ETL/refs/heads/main/etl/data/order_item.csv" in

  let processed_orders = List.map order_mapper (List.tl order_data) in
  let processed_order_items = List.map order_item_mapper (List.tl order_item_data) in

  let orders_with_items = inner_join_mapper processed_orders processed_order_items in

  let (status, origin) = get_cli_arguments () in 
  let filtered_orders_with_items = order_filter orders_with_items status origin in
  let summarized_orders = order_summarize filtered_orders_with_items in
  let formatted_summarized_orders = parse_floats summarized_orders in

  let db = Sqlite3.db_open "./data/output.db" in
  create_table db;
  save_all_to_db db formatted_summarized_orders;
  ignore (Sqlite3.db_close db)