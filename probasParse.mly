%token LPAREN RPAREN
%token KNOWING EQUAL AND TIMES
%token <string> SYMBOL
%start main
%type <string list> main
%type <string list> jd
%type <string list> decomp
%type <string list> expr
%type <string list> and_list

%%

main:
    jd EQUAL decomp { $1 @ $3 }
;

jd:
    LPAREN and_list RPAREN { $2 } 
;

decomp:
      expr TIMES decomp { $1 @ $3 }
    | expr { $1 }
;

expr:
      LPAREN expr RPAREN { print_endline "(expr)"; flush stdout; $2 } 
    | and_list KNOWING and_list { print_endline "and_list | and_list"; flush
    stdout; $1 @ $3 }
    | and_list { print_endline "and_list"; flush stdout; $1 }
;

and_list:
    SYMBOL AND and_list { $1 :: $3 }
    | SYMBOL { [$1] }
;
