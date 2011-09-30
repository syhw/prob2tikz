let _ =
    let lexbuf = Lexing.from_channel stdin in
    try let result = ProbasParse.main ProbasLex.token lexbuf in
    (
        print_endline "Parsed correctly";
        List.iter print_endline result
    )
    with Parsing.Parse_error ->
        print_endline "catched a parse error";

        let lexeme 	 = Lexing.lexeme lexbuf in
        let pos 	 = Lexing.lexeme_start_p lexbuf in
        let pos_str = Printf.sprintf "(%s:%d-%d)"
                        pos.Lexing.pos_fname
                        pos.Lexing.pos_lnum
                       (pos.Lexing.pos_cnum-pos.Lexing.pos_bol)
        in
        let msg 	 = "unexpected token : "^lexeme^pos_str in
        print_endline msg
