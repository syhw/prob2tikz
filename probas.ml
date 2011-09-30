let _ =
    try let lexbuf = Lexing.from_channel stdin in
    while true do
        try let result = ProbasParse.main ProbasLex.token lexbuf in
        (
            print_endline "Parsed correctly";
            List.iter print_endline result
        )
        with Parsing.Parse_error ->
            print_endline "catched a parse error"
    done
    with ProbasLex.Eof ->
        exit 0
