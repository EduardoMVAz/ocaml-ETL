open OUnit2 ;;
open Etl.Records ;;
open Etl.Mapper ;; 

let test_order_mapper _ =
  let input = ["1"; "112"; "2024-10-02T03:05:39"; "Pending"; "P"] in
  let expectation = {
    id = 1;
    client_id = 112;
    order_date = "2024-10-02T03:05:39";
    status = "Pending";
    origin = "P";
  } in
  assert_equal expectation (order_mapper input)

let test_order_item_mapper _ = 
  let input = ["12"; "224"; "8"; "139.42"; "0.12"] in
  let expectation = {
    order_id = 12;
    product_id = 224;
    quantity = 8;
    price = 139.42;
    tax = 0.12;
  } in
  assert_equal expectation (order_item_mapper input)

let test_inner_join_mapper _ =
  let orders = [
    {
      id = 1;
      client_id = 112;
      order_date = "2024-10-02T03:05:39";
      status = "Pending";
      origin = "P";
    };
    {
      id = 2;
      client_id = 117;
      order_date = "2024-08-17T03:05:39";
      status = "Complete";
      origin = "O";
    };
  ] in

  let order_items = [
    {
      order_id = 1;
      product_id = 210;
      quantity = 7;
      price = 12.79;
      tax = 0.08;
    };
    {
      order_id = 2;
      product_id = 203;
      quantity = 7;
      price = 110.37;
      tax = 0.15;
    };
  ] in

  let expectation = [
    {
      order_id = 1;
      client_id = 112;
      order_date = "2024-10-02T03:05:39";
      status = "Pending";
      origin = "P";
      product_id = 210;
      quantity = 7;
      price = 12.79;
      tax = 0.08;
    };
    {
      order_id = 2;
      client_id = 117;
      order_date = "2024-08-17T03:05:39";
      status = "Complete";
      origin = "O";
      product_id = 203;
      quantity = 7;
      price = 110.37;
      tax = 0.15;
    };
  ] in

  assert_equal expectation (inner_join_mapper orders order_items)

let suite =
  "Helper Tests" >::: [
    "test_order_mapper" >:: test_order_mapper;
    "test_order_item_mapper" >:: test_order_item_mapper;
    "test_inner_join_mapper" >:: test_inner_join_mapper;
  ]

let () =
  run_test_tt_main suite