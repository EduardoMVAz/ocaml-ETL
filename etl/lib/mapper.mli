open Records ;;

(** Function that receives the lines of the order.csv file and parses them into the order record. *)
val order_mapper : string list -> order

(** Function that receives the lines of the order_item.csv file and parses them into the order_item record. *)
val order_item_mapper : string list -> order_item

(** Function that receives the order and order_item records and joins them based on the order_id. 
    The function iterates through the order_items and matches them with their orders, creating
    a new record for each match.
*)
val inner_join_mapper : order list -> order_item list -> order_with_item list