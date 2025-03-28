type filters = {
  status: string;
  origin: string;
}

type order = {
  id: int;
  client_id: int;
  order_date: string;
  status: string;
  origin: string;
}

type order_item = {
  order_id: int;
  product_id: int;
  quantity: int;
  price: float;
  tax: float;
}

type order_with_item = {
  order_id: int;
  client_id: int;
  order_date: string;
  status: string;
  origin: string;
  product_id: int;
  quantity: int;
  price: float;
  tax: float;
}
