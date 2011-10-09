%{

let variables = ref [];;

let graphviz = false;;

let out = stdout;;

let init () =
    if graphviz then
        (
            output_string out "digraph bayesian_model {\n\
            rankdir=LR;\n";
        )
    else
        (
            (* Header *)
            output_string out "\\begin{figure}\n\
\\centering\n\
\\tikzstyle{var}=[circle, thick, draw=blue!80, fill=blue!20]\n\
\\begin{tikzpicture}[>=latex]\n";
            (* Variables *)
            List.map (fun v -> output_string out ("\\node[variable] "^v^
            "{"^v^"};\n")) !variables;
            (* Structure *)
            (*List.map (fun v1 v2 -> output_string out ("\\path "^v1^*)
            (*" edge "^v2^";\n")) !edges;*)
            ();
        )
;;


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
    jd EQUAL decomp EOF { (init (); $1; $3) }
;

jd:
    LPAREN and_list RPAREN { List.map add_to_variable $2 } 
;

decomp:
      expr TIMES decomp { $1 @ $3 }
    | expr { $1 }
;

expr:
      LPAREN expr RPAREN { print_endline "(expr)"; $2 }
    | and_list KNOWING and_list { print_endline "and_list | and_list"; [($1,
    $3)] }
    | and_list { print_endline "and_list"; [($1, [""])] } ;

and_list:
    SYMBOL AND and_list { $1 :: $3 }
    | SYMBOL { [$1] }
;

