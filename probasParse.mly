%token LPAREN RPAREN
%token KNOWING EQUAL AND TIMES
%token <string> SYMBOL
%start main
%type <string list> main
%type <string list> and_list
%%

main:
    expr { $1 }
;

expr:
    | LPAREN expr RPAREN { print_endline "(expr)"; flush stdout; $2 } 
    | expr EQUAL expr { print_endline "expr = expr"; flush stdout; $1 @ $3 }
    | expr TIMES expr { $1 @ $3 }
    | and_list KNOWING and_list { print_endline "and_list | and_list"; flush
    stdout; $1 @ $3 }
    | and_list { print_endline "and_list"; flush stdout; $1 }
;

and_list:
    | term AND and_list { $1 :: $3 }
    | term { [$1] }
;

term:
    | SYMBOL { $1 }
;

