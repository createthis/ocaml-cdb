# arch-tag: 879F039C-05DC-11D8-B67C-000393DC8AE4
MKLIB=ocamlmklib
OCAMLMKTOP=ocamlmktop
OCAMLOPT=ocamlopt
OCAMLC=ocamlc

PARTS=cdb.cmx
MAIN_FILE=main.ml
EXECUTABLE=my_program

.SUFFIXES: .ml .mli .cmi .cmx

.PHONY: $(PARTS)

all: libcdb docs $(EXECUTABLE)

testtop: $(PARTS)
	$(OCAMLMKTOP) -o testtop \
		cdb.cmo

libcdb: $(PARTS)
	$(MKLIB) -o cdb \
		cdb.cmo \
		cdb.cmx
	rm -f libcdb.a
	ln cdb.a libcdb.a

$(EXECUTABLE): libcdb $(MAIN_FILE)
	$(OCAMLC) -o $(EXECUTABLE) cdb.cmo $(MAIN_FILE)

docs: $(PARTS)
	mkdir -p doc
	ocamldoc -t "CDB OCaml Docs" -keep-code -colorize-code -d doc -html \
		*.mli *.ml

clean:
	rm -rf testtop *.a *.cma *.cmxa *.cmx *.cmi *.cmo *.o doc $(EXECUTABLE)

.ml.mli:
	$(OCAMLOPT) -i $< > $@

.mli.cmi: $<
	$(MKLIB) $< `echo $< | sed s/.mli/.ml/`

# Deps created by ocamldep
cdb.cmo: cdb.cmi 
cdb.cmx: cdb.cmi 
