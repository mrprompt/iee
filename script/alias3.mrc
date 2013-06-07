; fx keys
alias cf1 if ($isfile($mircdiratalhos.txt)) run $mircdiratalhos.txt 
alias f2 server $entry(Entre com o endereço do servidor. ex: irc.trix.net)
alias cf2 dlgservers
alias sf2 quit $entry(Mensagem de quit)
alias f3 .nickserv identify $$?*="Senha do nick:"
alias cf3 .nickserv register $$?*="Digite uma senha para o nick:"
alias sf3 .nickserv ghost $entry(Nick a ser derrubado) $$?*="Senha:"
alias f4 .chanserv op # $me
alias F5 .mp3random
alias cF5 .mp3player
alias sF5 .mp3
alias f6 clear
alias sf6 clearall
alias f7 away $entry(Qual a mensagem de away?)
alias sf7 awaysys
alias f8 themes
alias f10 %_f10
alias f12 config
; eof
