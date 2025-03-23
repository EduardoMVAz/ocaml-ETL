open Records ;;

let order_filter (orders_with_items: order_with_item list) (status: string) (origin: string) : order_with_item list = 
  List.filter ( fun owi ->
    (status = "" || owi.status = status) &&
    (origin = "" || owi.origin = origin)
  ) orders_with_items