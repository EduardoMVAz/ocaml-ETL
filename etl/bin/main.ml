open Etl.Reader ;;
open Etl.Mapper ;;

let () =
  print_endline "Starting ETL pipeline...";
  let order_data = read_csv_url "https://raw.githubusercontent.com/JoaoLucasMBC/etl-ocaml/refs/heads/main/etl/data/order.csv" in
  let order_item_data = read_csv_url "https://raw.githubusercontent.com/JoaoLucasMBC/etl-ocaml/refs/heads/main/etl/data/order_item.csv" in

  let processed_orders = List.map order_mapper order_data in
  let processed_order_items = List.map order_item_mapper order_item_data in

  let _ = inner_join_mapper processed_orders processed_order_items in

  () ;;