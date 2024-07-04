This is [Dustin Sallings](https://github.com/dustin) OCaml CDB library, pulled from the 2007 
wayback machine.

It has been updated to work with OCaml 5.2.0 by [Jesse](https://github.com/createthis/ocaml-cdb).

# What is CDB?

CDB is a simple and elegant constant database. Think of it as an associative array on disk.
Reads are fast, but writes are slow because the whole file needs to be rebuilt for every change.

It comes from a time when CPUs were much slower, disks were much smaller, and being clever 
about how you use resources mattered much more. Today, SQLite and/or JSON are probably better 
choices in most situations.

Further reading:

1. https://cr.yp.to/cdb/cdb.txt and https://cr.yp.to/cdb.html
2. http://www.cse.yorku.ca/~oz/hash.html
3. https://www.unixuser.org/~euske/doc/cdbinternals/index.html

# Getting Started

```bash
opam install cdb
```

## Read a value

```ocaml
(* Open the CDB for searching *)
let cdb_file = Cdb.open_cdb_in "my_cdb.cdb" in

(* Get matches for a key *)
let matches = Cdb.get_matches cdb_file "key1" in

(* Iterate over the matches and print them *)
Seq.iter (fun value -> print_endline ("Found value: " ^ value)) matches;

(* Close the CDB file *)
Cdb.close_cdb_in cdb_file
```

## Writing values

```ocaml
(* Create and populate a CDB *)
let creator = Cdb.open_out "my_cdb.cdb" in
Cdb.add creator "key1" "value1";
Cdb.add creator "key2" "value2";
Cdb.close_cdb_out creator;
```

# Contributor

```bash
dune build
```

# Test

```bash
dune exec ./test/main.exe
```
