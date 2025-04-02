open Records ;;

(** Function for filtering the orders_with_items (joined record) based on the filters chosen by the user, Origin and Status. *)
let order_filter (orders_with_items: order_with_item list) (status: string) (origin: string) : order_with_item list = 
  List.filter ( fun owi ->
    (status = "" || owi.status = status) &&
    (origin = "" || owi.origin = origin)
  ) orders_with_items

(** Function for reducing the orders_with_items (joined record) into the desired output, a summary for each order. *)
let order_summarize (filtered_orders_with_items: order_with_item list) : (int * float * float) list = 
  List.fold_left (fun acc filtered_order_with_item ->
    let existing_order, other_orders = List.partition (fun (id, _, _) -> id = filtered_order_with_item.order_id) acc in 
    match existing_order with
    | [] -> (
        filtered_order_with_item.order_id, 
        (float_of_int filtered_order_with_item.quantity) *. filtered_order_with_item.price,
        (float_of_int filtered_order_with_item.quantity) *. filtered_order_with_item.price *. filtered_order_with_item.tax
      ) :: acc
    | [(_, curr_total_amount, curr_total_taxes)] ->
      (
        filtered_order_with_item.order_id,
        curr_total_amount +. (float_of_int filtered_order_with_item.quantity) *. filtered_order_with_item.price,
        curr_total_taxes +. (float_of_int filtered_order_with_item.quantity) *. filtered_order_with_item.price *. filtered_order_with_item.tax
      ) :: other_orders 
    | _ -> failwith "Unexpected duplicate order_id"
  ) [] filtered_orders_with_items