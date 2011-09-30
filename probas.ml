let _ =
    try let lexbuf = Lexing.from_channel stdin in
    while true do
        let result = ProbasParse.main ProbasLex.token lexbuf in
        (
            print_endline "Parsed correctly";
            List.iter (fun r -> print_endline r; flush stdout) result
        )
    done
    with ProbasLex.Eof ->
        exit 0
