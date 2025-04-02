open Records ;;

(** Function that receives the lines of the order.csv file and parses them into the order record. *)
let order_mapper (order: string list) : order =
  match order with
  | id :: client_id :: order_date :: status :: origin :: [] ->
    {
      id = int_of_string id;
      client_id = int_of_string client_id;
      order_date = order_date;
      status = status;
      origin = origin;
    }
  | _ -> failwith "Unable to map order entity" ;;

(** Function that receives the lines of the order_item.csv file and parses them into the order_item record. *)
let order_item_mapper (order_item: string list) : order_item = 
  match order_item with
  | order_id :: product_id :: quantity :: price :: tax :: [] ->
    {
      order_id = int_of_string order_id;
      product_id = int_of_string product_id;
      quantity = int_of_string quantity;
      price = float_of_string price;
      tax = float_of_string tax;
    }
    | _ -> failwith "Unable to map order item entity" ;;

(** Function that receives the order and order_item records and joins them based on the order_id. 
    The function iterates through the order_items and matches them with their orders, creating
    a new record for each match.
*)
let rec inner_join_mapper (orders: order list) (order_items: order_item list) : order_with_item list =
  match order_items with
  | [] -> []
  | order_item :: t -> 
    match List.find_opt (fun (order: order) -> order.id = order_item.order_id) orders with
    | Some order -> 
      {
        order_id = order.id;
        client_id = order.client_id;
        order_date = order.order_date;
        status = order.status;
        origin = order.origin;
        product_id = order_item.product_id;
        quantity = order_item.quantity;
        price = order_item.price;
        tax = order_item.tax
      } :: inner_join_mapper orders t
    | _ -> failwith "Unable to join orders with order items" ;;
