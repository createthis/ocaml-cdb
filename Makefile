# arch-tag: 879F039C-05DC-11D8-B67C-000393DC8AE4
MKLIB=ocamlmklib
OCAMLMKTOP=ocamlmktop
OCAMLOPT=ocamlopt
OCAMLC=ocamlc

PARTS=extstring.cmx fileutils.cmx lru.cmx linkedlist.cmx base64.cmx cdb.cmx \
	netstring.cmx extlist.cmx extoption.cmx extstream.cmx math.cmx

.SUFFIXES: .ml .mli .cmi .cmx

.PHONY: $(PARTS)

all: libspy docs

testtop: $(PARTS)
	$(OCAMLMKTOP) -o testtop unix.cma \
		fileutils.cmo extstring.cmo extlist.cmo extoption.cmo \
		extstream.cmo linkedlist.cmo lru.cmo base64.cmo \
		cdb.cmo netstring.cmo

libspy: $(PARTS)
	$(MKLIB) -o spy \
		fileutils.cmo extstring.cmo extlist.cmo extoption.cmo \
		extstream.cmo linkedlist.cmo lru.cmo base64.cmo \
		cdb.cmo netstring.cmo math.cmo \
		fileutils.cmx extstring.cmx extlist.cmx extoption.cmx \
		extstream.cmx linkedlist.cmx lru.cmx base64.cmx \
		cdb.cmx netstring.cmx math.cmx
	rm -f libspy.a
	ln spy.a libspy.a


docs: $(PARTS)
	mkdir -p doc
	ocamldoc -t "Dustin's OCaml Docs" -keep-code -colorize-code -d doc -html \
		*.mli *.ml

install-docs: docs
	cp doc/* /afs/spy.net/home/dustin/public_html/projects/ocaml/doc

clean:
	rm -rf testtop *.a *.cma *.cmxa *.cmx *.cmi *.cmo *.o doc

# .ml.mli:
	# $(OCAMLOPT) -i $< > $@

.mli.cmi: $<
	$(MKLIB) $< `echo $< | sed s/.mli/.ml/`

# Deps created by ocamldep
cdb.cmo: extoption.cmi cdb.cmi 
cdb.cmx: extoption.cmx cdb.cmi 
