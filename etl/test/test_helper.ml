open OUnit2 ;;
open Etl.Helper ;;

let test_parse_status _ = 
  assert_equal "Pending" (parse_status "Pending") ;
  assert_equal "Completed" (parse_status "Completed") ;
  assert_equal "Cancelled" (parse_status "Cancelled")

let test_parse_origin _ = 
  assert_equal "O" (parse_origin "O") ;
  assert_equal "P" (parse_origin "P")

let test_parse_to_csv _ = 
  let input = [(1, 50.50, 5.0); (2, 100.0, 10.0); (4, 30.0, 3.0)] in
  let expectation = [
    ["order_id"; "total_amount"; "total_taxes"];
    ["1"; "50.50"; "5.00"];
    ["2"; "100.00"; "10.00"];
    ["4"; "30.00"; "3.00"];
  ] in
  assert_equal expectation (parse_to_csv input)

let suite =
  "Helper Tests" >::: [
    "test_parse_status" >:: test_parse_status;
    "test_parse_origin" >:: test_parse_origin;
    "test_parse_to_csv" >:: test_parse_to_csv;
  ]

let () =
  run_test_tt_main suite