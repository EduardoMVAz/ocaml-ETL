open Csv

let read_csv filename =
  let ic = open_in filename in
  let csv_data = Csv.load ic in
  close_in ic;
  csv_data

let write_csv filename data =
  let oc = open_out filename in
  Csv.output_all oc data;
  close_out oc
