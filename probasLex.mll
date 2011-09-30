{
open ProbasParse
exception Eof
}

let ws = ['\n''\t'' ']
let alphanum = ['a'-'z''A'-'Z''0'-'9']
let symbolizable = alphanum ['_''^''+''-'] 

rule token = parse
  | ws+ 
  | "$"
  | "$$"
  | "\\begin{equation}"
  | "\\end{equation}"
  {token lexbuf}
  | alphanum+symbolizable* as str {SYMBOL str}
  | "P(" {LPAREN}
  | ')' {RPAREN}
  | '|' {KNOWING}
  | '='
  | "\\propto" {EQUAL}
  | ',' {AND}
  | eof {raise Eof}
  | _ as c { print_char c; token lexbuf }
(* {
let main () =

    let cin =
        if Array.length Sys.argv > 1
        then open_in Sys.argv.(1)
        else stdin
    in
    let lexbuf = Lexing.from_channel cin in
    token lexbuf

let _ = Printexc.print main ()
  }*)
