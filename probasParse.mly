%{

let variables = ref [];;

let add_to_variable v =
    variables := v::!variables;;

%}

%token LPAREN RPAREN
%token KNOWING EQUAL AND TIMES
%token <string> SYMBOL
%token EOF
%start main
%type <(string list * string list) list> main

%%

main:
    jd EQUAL decomp EOF { ($1; $3;) }
;

jd:
    LPAREN and_list RPAREN { List.map add_to_variable $2 } 
;

decomp:
      expr TIMES decomp { $1 @ $3 }
    | expr { $1 }
;

expr:
      LPAREN expr RPAREN { $2 }
    | and_list KNOWING and_list { [($1, $3)] }
    | and_list { [($1, [""])] } 
;

and_list:
    SYMBOL AND and_list { $1 :: $3 }
    | SYMBOL { [$1] }
;

