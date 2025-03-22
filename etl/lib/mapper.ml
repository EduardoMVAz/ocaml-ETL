open Helper ;;
open Records ;;

let order_mapper (order: string list) : order =
  match order with
  | id :: client_id :: order_date :: status :: origin :: [] ->
    {
      id = parse_string_to_int id;
      client_id = parse_string_to_int client_id;
      order_date = parse_string_to_ptime order_date;
      status = status;
      origin = origin;
    }
  | _ -> failwith "Unable to map order entity" ;;

let order_item_mapper (order_item: string list) : order_item = 
  match order_item with
  | order_id :: product_id :: quantity :: price :: tax :: [] ->
    {
      order_id = parse_string_to_int order_id;
      product_id = parse_string_to_int product_id;
      quantity = parse_string_to_int quantity;
      price = parse_string_to_float price;
      tax = parse_string_to_float tax;
    }
    | _ -> failwith "Unable to map order item entity" ;;

let rec inner_join_mapper (orders: order list) (order_items: order_item list) : inner_join_order_order_item list =
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
