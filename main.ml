(* main.ml *)
let () =
  (* Create and populate a CDB *)
  let creator = Cdb.open_out "my_cdb.cdb" in
  Cdb.add creator "key1" "value1";
  Cdb.add creator "key2" "value2";
  Cdb.close_cdb_out creator;

  (* Open the CDB for searching *)
  let cdb_file = Cdb.open_cdb_in "my_cdb.cdb" in

  (* Get matches for a key *)
  let matches = Cdb.get_matches cdb_file "key1" in

  (* Iterate over the matches and print them *)
  Seq.iter (fun value -> print_endline ("Found value: " ^ value)) matches;

  (* Close the CDB file *)
  Cdb.close_cdb_in cdb_file

