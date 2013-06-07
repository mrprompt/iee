; -- iee script - várias diálogs
;
; -- mudar o tópico
dialog topic {
  title "Tópico"
  size -1 -1 400 90
  icon script\iee2.ico
  box "", 1, 0 0 400 90
  text "EditarTópico:", 2, 7 10 100 20, left
  edit "", 3, 5 25 390 20, autohs
  button "&Aplicar", 4, 10 55 80 25, ok default
  button "&Cancela", 5, 100 55 80 25, cancel
  button "&Limpar", 6, 190 55 80 25
  icon 7, 355 53 32 32, script\iee2.ico
}
on *:dialog:topic:init:0:did -ra topic 3 $chan(%_chan).topic
on *:dialog:topic:sclick:4:topic %_chan $did(3).text | unset %_chan
on *:dialog:topic:sclick:6:did -r topic 3
;
; -- modos de canal
alias channelmodes { dialog -m channelmodes channelmodes | var %x = 0 | var %y = $chan(0) | while (%y > %x) { inc %x | did -a channelmodes 2 $channel(%x) } }
alias cmodes channelmodes
dialog channelmodes {
  title $strip($gettok($ver,1,32)) Channel Modes
  size -1 -1 162 100
  icon script\iee2.ico
  option dbu
  text "Set modes / topic de:", 1, 2 5 50 8, right
  combo 2, 60 1 100 100, drop sort edit

  box "Modos", 3, 2 15 158 40
  text "modos atuais", 4, 5 25 45 8, right
  edit %_chan.modes, 5, 55 20 100 11, autohs
  text "mudar para:", 6, 5 40 45 8, right
  edit "", 7, 55 36 100 11, autohs

  box "topic", 8, 2 55 158 27
  text %_chan, 9, 5 70 47 8, right
  edit %_chan.topic, 10, 55 67 100 11, autohs

  button "&OK", 11, 65 85 45 12, ok
  button "&Cancel", 12, 115 85 45 12, cancel
}
on *:dialog:channelmodes:sclick:2:{ did -ra $dname 5 $chan($did(2).text).mode | did -ra $dname 9 $did(2).text | did -ra $dname 10 $chan($did(2).text).topic }
on *:dialog:channelmodes:sclick:11:{ if ($did(7).text != $null) .mode $did(2).text $did(7).text | topic $did(2).text $did(10).text }
;

; -- file server
alias fserv if ($dialog(fserv)) return | else dialog -m fserv fserv
dialog fserv {
  title "FileServer"
  size -1 -1 100 107
  icon script\iee2.ico
  option type dbu
  box "Nick", 1, 1 1 99 20
  edit "", 3, 3 9 95 11, autohs 
  box "Nr. máximo de arquivos por vez:", 4, 1 22 99 20
  edit "", 5, 3 30 95 11, autohs
  box "Mensagem de entrada:", 6, 1 42 99 20
  edit "", 7, 3 49 95 11, autohs
  box "Diretório:", 8, 1 63 99 20
  edit "", 9, 3 70 95 11, autohs
  button "msg. entr.", 10, 3 85 30 9
  button "&diretório", 11, 36 85 30 9
  button "&Abrir", 12, 68 85 30 9
  button "&Fechar", 13, 1 96 99 9
  button "", 999, 0 0 0 0, hide ok
}
on *:dialog:fserv:init:*:did -a fserv 5 $readini script\options.ini fserv max | did -a fserv 7 $readini script\options.ini fserv file | did -a fserv 9 $readini script\options.ini fserv dir
on *:dialog:fserv:sclick:10:.timer 1 0 settext
on *:dialog:fserv:sclick:11:.timer 1 0 setdir
on *:dialog:fserv:sclick:12:if ($did(fserv,3).text != $null) .fserve $did(fserv,3).text $did(fserv,5).text $did(fserv,9).text $did(fserv,7).text
on *:dialog:fserv:sclick:13:{
  if ($did(fserv,5).text != $null) { .writeini script\options.ini fserv max $did(fserv,5).text }
  if ($did(fserv,5).text == $null) { .writeini script\options.ini serv max 5 }
  dialog -c fserv fserv
}
alias -l settext .writeini script\options.ini fserv file $$file="Selecione o arquivo de entrada para o servidor de arquivos" fserv\*.* | did -r fserv 7 | did -a fserv 7 $readini script\options.ini fserv file
alias -l setdir  .writeini script\options.ini fserv dir $$sdir="Selecione o diretório para o servidor de arquivos" | did -ra fserv 9 $readini -n script\options.ini fserv dir
;
; -- lista de servidores
dialog servers {
  title $strip($gettok($ver,1,32)) - Servidores
  size -1 -1 350 198
  icon script\iee2.ico
  box "Servidores", 1, 1 1 350 170
  list 2, 2 15 200 165
  text "Server:", 3, 205 15 33 17, left
  edit "", 4, 205 28 140 19
  icon 5, 260 50 32 32, script\iee2.ico, noborder
  text "Selecione o servidor na lista ao lado para conectar, ou adicione um servidor de sua preferência.", 6, 205 90 145 55
  check "Abrir ao iniciar...", 7, 205 150 92 15
  button "&Conectar", 90, 5 175 70 20, ok
  button "&Adicionar", 91, 80 175 70 20
  button "&Deletar", 92, 155 175 70 20
  button "&Limpar", 93, 230 175 70 20
}
on *:dialog:servers:init:*:.lstsvr | if ($readini(script\options.ini,others,servers.dlg) == 1) did -c servers 7
on *:dialog:servers:dclick:2:.server $did(servers,2).seltext | dialog -c servers servers
on *:dialog:servers:sclick:2:did -ra servers 4 $did(servers,2, $did(servers,2).sel).text
on *:dialog:servers:sclick:7:.writeini -n script\options.ini others servers.dlg $did(servers,7).state
on *:dialog:servers:sclick:90:if ($did(servers,4).text != $null) { .server $did(servers,4).text }
on *:dialog:servers:sclick:91:{
  var %svr = $entry(Entre com o endereço do servidor (ex: servidor:porta))
  if (%svr != $null) && (%svr !isin %servers) .set %servers %servers $+ %svr  $+ $chr(44)
  .lstsvr
}
on *:dialog:servers:sclick:92:if ($did(2).sel != $null) { set %servers $deltok(%servers,$did(servers,2).sel,44) $+ $chr(44) | .timer 1 0 .lstsvr }
on *:dialog:servers:sclick:93:.unset %servers | lstsvr
alias -l lstsvr { did -r servers 2,4 | var %x 0 | while ($numtok(%servers,44) > %x) { inc %x | did -a servers 2 $gettok(%servers,%x,44) } }
;
; -- ignore
dialog ignore {
  title $strip($gettok($ver,1,32)) Sistema para Ignorar
  size -1 -1 90 115
  option type dbu
  icon script\iee2.ico

  box "Nick/Endereço", 1, 1 1 89 20
  combo 2, 3 9 85 80, drop edit

  box "Tipo", 3, 1 22 89 38
  check "Privado (PVT)", 4, 3 30 45 8
  check "Notícias", 5, 3 40 30 8
  check "Convites", 6, 3 50 30 8
  check "Canal", 7, 50 30 30 8
  check "CTCPs", 8, 50 40 30 8
  check "Cores", 9, 50 50 30 8

  box "Tempo", 10, 1 60 89 40
  radio "Permanente", 11, 3 68 50 8
  radio "Segundos", 12, 3 79 33 8
  edit "", 13, 38 75 47 11, autohs disabled
  radio "Minutos", 14, 3 90 32 8
  edit "", 15, 38 87 47 11, autohs disabled
  button "&Ignorar", 16, 1 103 26 12, ok
  button "&Ajuda", 17, 32 103 26 12,disabled
  button "&Cancelar", 18, 64 103 26 12, cancel
}
on *:dialog:ignore:init:*:did -c ignore 11 | did -c ignore 2 1
on *:dialog:ignore:sclick:11:did -b ignore 13,15
on *:dialog:ignore:sclick:12:did -e ignore 13 | did -b ignore 15
on *:dialog:ignore:sclick:14:did -e ignore 15 | did -b ignore 13
on *:dialog:ignore:sclick:16:{
  unset %_ign
  if ($did(ignore,4).state) set %_ign %_ign $+ p
  if ($did(ignore,5).state) set %_ign %_ign $+ n
  if ($did(ignore,6).state) set %_ign %_ign $+ i
  if ($did(ignore,7).state) set %_ign %_ign $+ c
  if ($did(ignore,8).state) set %_ign %_ign $+ t
  if ($did(ignore,9).state) set %_ign %_ign $+ k
  if ($did(ignore,11).state) ignore - $+ %_ign $did(ignore,2).text
  if ($did(ignore,12).state) ignore -u $+ $calc($did(ignore,13).text * 1) - $+ %_ign  $did(ignore,2).text
  if ($did(ignore,14).state) ignore -u $+ $calc($did(ignore,15).text * 60) - $+ %_ign $did(ignore,2).text
}
;
; -- auto-join
alias autojoin if (!$dialog(autojoin)) dialog -m autojoin autojoin
dialog autojoin {
  title $strip($gettok($ver,1,32)) autojoin
  size -1 -1 150 95
  icon script\iee2.ico
  option type dbu
  box "", 1, 2 1 146 72
  list 2, 4 7 95 70
  button "&Adicionar", 3, 103 8 40 11
  button "&Remover",  4, 103 20 40 11
  button "R&emover todos",   5, 103 32 40 11
  button "E&ntrar", 6, 103 44 40 11
  button "En&trar em todos", 7, 103 56 40 11
  check "Ativar auto-join", 8, 2 75 73 8
  text "Entrar nos canais em", 9, 2 85 47 8, left
  edit "", 10, 50 84 20 9, autohs
  text "segundos", 11, 73 85 23 8, left
  icon 13 , 115 75 20 20, script\iee2.ico
  button "&ok", 999, 0 0 0 0, hide ok
}
on *:dialog:autojoin:init:0:{
  if ($group(#autojoin) == on) { did -c autojoin 8 | did -e autojoin 10 }
  if ($group(#autojoin) == off) { did -u autojoin 8 | did -b autojoin 10 }
  did -ra autojoin 10 $readini(script\options.ini,others,autojoin.secs)
  .timer 1 0 addchan 
}
on *:dialog:autojoin:sclick:3:{ 
  var %chan = $entry(Nome do canal (#canal):)
  if (%chan != $null) && (%chan !isin %canais) { 
    .set %canais %canais $+ %chan $+ $chr(44)
    .timer 1 0 addchan
    did -r autojoin 2 
  } 
}
on *:dialog:autojoin:sclick:4:{ if ($did(2).sel != $null) { set %canais $deltok(%canais,$did(autojoin,2).sel,44) $+ $chr(44) | .timer 1 0 addchan } }
on *:dialog:autojoin:sclick:5:{ .unset %canais | did -r autojoin 2 }
on *:dialog:autojoin:sclick:6:{ if ($did(2).sel != $null) .join $did(autojoin,2, $did(autojoin,2).sel).text }
on *:dialog:autojoin:sclick:7:{ .join %canais }
on *:dialog:autojoin:sclick:8:{ if ($did(8).state == 0) { .disable #autojoin | did -b autojoin 10 } | if ($did(8).state == 1) { .enable #autojoin | did -e autojoin 10 } }
on *:dialog:autojoin:edit:10:.writeini -n script\options.ini others autojoin.secs $did(10).text
alias -l addchan { did -r autojoin 2 | set %x 0 | :loop | inc %x | if ($numtok(%canais,44) < %x) { goto fim } | did -a autojoin 2 $gettok(%canais,%x,44) | goto loop | :fim }
alias -l canais return $gettok(%canais,$1,44)
;
; -- auto-identify
dialog ai {
  title $strip($gettok($ver,1-3,32)) - Auto Identify
  size -1 -1 150 85
  icon script\iee2.ico
  option type dbu
  box "", 1, 2 1 146 70
  list 2, 4 7 95 70
  button "&Adicionar", 3, 103 8 40 11
  button "&Editar",  4, 103 20 40 11
  button "&Deletar",   5, 103 32 40 11
  icon 6, 115 50 20 20, script\iee2.ico
  check "identificar automaticamente", 7, 2 75 75 8
  button "&Fechar", 8, 103 73 40 11, ok
}
on *:dialog:ai:init:0:{
  if ($isfile(script\pwd.ini)) .timer 1 0 `listnicks
  if ($readini(script\options.ini,others,autoidentify) == 1) did -c ai 7
  else did -u ai 7
}
on *:dialog:ai:sclick:3:.timer 1 0 dialog -mo pwd pwd
on *:dialog:ai:sclick:4:{ 
  if ($did(ai,2).seltext != <none>) {
    dialog -mo pwd pwd
    var %nick $did(ai,2).seltext
    did -ra pwd 2 %nick $ini(script\pwd.ini,1,$did(ai,1).sel)
    var %pass $readini script\pwd.ini nicks %nick
    did -ra pwd 4 $decode(%pass)
  }
}
on *:dialog:ai:sclick:5:if ($did(ai,2).seltext != <none>) { .remini script\pwd.ini nicks $did(ai,2).seltext | did -d ai 2 $did(ai,2).sel }
on *:dialog:ai:sclick:7:{
  if ($did(7).state) .writeini -n script\options.ini others autoidentify 1
  else .writeini -n script\options.ini others autoidentify 0
}
;
alias ai if ($dialog(ai)) return | else dialog -mo ai ai
alias -l `listnicks {
  did -r ai 2
  var %i 0
  while (%i < $ini(script\pwd.ini,1,0)) { 
    inc %i 
    did -a ai 2 $ini(script\pwd.ini,1,%i) 
  } 
}
;
dialog pwd {
  size -1 -1 192 75
  icon script\iee2.ico
  text "Nickname:" , 1, 2 7 50 15
  edit "", 2, 55 3 135 20, autohs
  text "Senha:", 3, 2 25 50 15
  edit "", 4, 55 21 135 20, autohs password
  box "", 5, 1 40 191 32
  button "&OK", 6, 4 49 80 20, ok
  button "&cancel", 7, 109 50 80 20, cancel
}
on *:dialog:pwd:sclick:6:if ($did(pwd,1).text != $null) .writeini script\pwd.ini nicks $did(pwd,2).text $encode($did(pwd,4).text) | if ($dialog(ai)) .timer 1 1 `listnicks
;
; - entrada padrão de texto: $entry(Texto)
alias entry {
  if ($1 != $null) {
    set %_entry.text $1-
    return $$dialog(entry,entry,-4)
  }
}
dialog entry {
  title $strip($gettok($ver,1,32)) - entrada de texto
  icon script\iee2.ico
  size -1 -1 308 100
  text %_entry.text, 1, 1 1 266 50
  icon 2, 272 5 32 32, $shortfn(script\iee2.ico), noborder
  edit "", 3, 1 53 266 20, result autohs
  button "OK", 4, 45 77 76 20, ok
  button "Cancel", 5, 157 77 76 20, cancel
}
on *:dialog:entry:init:*:did -f $dname 3
; eof
