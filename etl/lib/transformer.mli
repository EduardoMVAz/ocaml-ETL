open Records ;;

(** Function for filtering the orders_with_items (joined record) based on the filters chosen by the user, Origin and Status. *)
val order_filter : order_with_item list -> string -> string -> order_with_item list

(** Function for reducing the orders_with_items (joined record) into the desired output, a summary for each order. *)
val order_summarize : order_with_item list -> (int * float * float) list