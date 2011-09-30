all: probasLex.mll probasParse.mly probas.ml
	ocamllex probasLex.mll       # generates probasLex.ml
	ocamlyacc probasParse.mly     # generates probasParse.ml and probasParse.mli
	ocamlc -c probasParse.mli
	ocamlc -c probasLex.ml
	ocamlc -c probasParse.ml
	ocamlc -c probas.ml
	ocamlc -o probas probasLex.cmo probasParse.cmo probas.cmo

run:
	./probas < ../gbm.tex

clean:
	rm *.cmo *.cmi probas

