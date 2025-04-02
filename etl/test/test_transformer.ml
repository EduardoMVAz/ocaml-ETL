open OUnit2 ;;
open Etl.Records ;;
open Etl.Transformer ;;

let test_order_filter _ =
  let input = [
    {
      order_id = 1;
      client_id = 100;
      order_date = "2024-01-01";
      status = "Pending";
      origin = "O";
      product_id = 10;
      quantity = 2;
      price = 50.0;
      tax = 0.1;
    };
    {
      order_id = 2;
      client_id = 101;
      order_date = "2024-01-02";
      status = "Completed";
      origin = "P";
      product_id = 11;
      quantity = 1;
      price = 100.0;
      tax = 0.2;
    };
    {
      order_id = 3;
      client_id = 102;
      order_date = "2024-01-03";
      status = "Cancelled";
      origin = "O";
      product_id = 12;
      quantity = 3;
      price = 70.0;
      tax = 0.15;
    };
  ] in

  let result1 = order_filter input "Pending" "" in
  assert_equal [1] (List.map (fun o -> o.order_id) result1);

  let result2 = order_filter input "" "P" in
  assert_equal [2] (List.map (fun o -> o.order_id) result2);

  let result3 = order_filter input "Cancelled" "O" in
  assert_equal [3] (List.map (fun o -> o.order_id) result3);

  let result4 = order_filter input "Completed" "O" in
  assert_equal [] (List.map (fun o -> o.order_id) result4);

  let result5 = order_filter input "" "" in
  assert_equal [1; 2; 3] (List.map (fun o -> o.order_id) result5)

let test_order_summarize _ =
  let input = [
    {
      order_id = 1;
      client_id = 100;
      order_date = "2024-01-01";
      status = "Pending";
      origin = "O";
      product_id = 10;
      quantity = 2;
      price = 50.0;
      tax = 0.1;
    };
    {
      order_id = 1;
      client_id = 100;
      order_date = "2024-01-01";
      status = "Pending";
      origin = "O";
      product_id = 11;
      quantity = 1;
      price = 100.0;
      tax = 0.2;
    };
  ] in
  let expectation = [(1, 200.0, 30.0)] in
  assert_equal expectation (order_summarize input)

let suite =
  "Summary Tests" >::: [
    "test_order_filter" >:: test_order_filter;
    "test_order_summarize" >:: test_order_summarize;
  ]

let () = run_test_tt_main suite