.PHONY: all clean
EXEC=probas
OBJ=probasLex.cmo probasParse.cmo probas.cmo
GENSRC=probasParse.ml probasParse.mli probasLex.ml probasLex.mli 

all: $(EXEC)

$(EXEC): $(OBJ)
	ocamlc -o $@ $+

probasParse.cmo: probasParse.ml probasParse.cmi
	ocamlc -c $<

%.cmo: %.ml
	ocamlc -c $<

%.cmi: %.mli
	ocamlc -c $<

%.ml: %.mll
	ocamllex $<

%.ml: %.mly
	ocamlyacc $<

%.mli: %.mly
	ocamlyacc $<

probasLex.ml: probasParse.cmo

run:
	./probas < valid.txt
	./probas < invalid.txt

pdf:
	pdflatex test
	open test.pdf

clean:
	rm -f *.cmo *.cmi $(EXEC) $(GENSRC)
