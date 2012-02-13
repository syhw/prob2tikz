let print_tuple t =
    print_endline ((String.concat "," (fst t)) ^ "|" ^ (String.concat "," (snd t)));;

let tikz_arrow_s a b = 
    if b <> "" then
        "(" ^ a ^ ") edge[thick] (" ^ b ^ ")"
    else
        "";;

let tikz_arrows t = 
    let tmpf = tikz_arrow_s (String.concat "," (fst t)) in
    String.concat "\r" (List.map tmpf (snd t));;

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

let finish () =
    if graphviz then
        (
            (* NON IMPL *)
            print_endline "non impl!!";
        )
    else
        (
            output_string out "\\end{tikzpicture}\n\
            \\end{figure}";
        )
;;

let _ =
    let lexbuf = Lexing.from_channel stdin in
    try let result = ProbasParse.main ProbasLex.token lexbuf in
    (
        init ();
        if out <> stdout then
            (
                print_endline "Parsed correctly";
                List.iter print_tuple result
            )
        else
            ();
        if graphviz then
            () (*Unimpl*)
        else
            let tmpf x = output_string out (x ^ "\n") in
            List.iter tmpf (List.map tikz_arrows result)
        finish ();
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
