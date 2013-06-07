; -- iee script - configuração
;
alias config {
  .dialog -md dlgconfig dlgconfig
  if ($1) goto $1
  else goto geral
  :geral | did -fu dlgconfig 1 | halt
  :away | did -fu dlgconfig 2 | halt
  :nc | did -fu dlgconfig 3 | halt
  :auto-cor | did -fu dlgconfig 4 | halt
  :ctcp | did -fu dlgconfig 5 | halt
  :about | did -fu dlgconfig 6 | halt
}
dialog dlgconfig {
  title $strip($gettok($ver,1-3,32)) - Setup
  size -1 -1 430 352
  icon script\iee2.ico
  tab "Geral", 1, 1 109 427 211
  tab "Away system", 2
  tab "Nick completion", 3
  tab "Auto-cor", 4
  tab "CTCP", 5
  tab "About", 6
  button "Confirma", 7, 145 325 92 24, ok
  button "Cancela", 8, 241 325 92 24, cancel
  button "Ajuda", 9, 337 325 92 24, disabled
  icon 10, 2 2 428 103, $shortfn(script\img\#iee script-setup.jpg)
  box "whois", 11, 9 144 112 72, tab 1
  radio "na janela ativa", 12, 15 164 91 13, tab 1, group
  radio "em outra janela", 13, 15 180 91 13, tab 1
  radio "em dialog", 14, 15 196 91 13, tab 1
  box "names", 15, 125 144 112 72, tab 1
  radio "no canal", 16, 135 164 91 13, tab 1, group
  radio "no status", 17, 135 180 91 13, tab 1
  radio "não mostrar", 18, 135 196 91 13, tab 1
  box "motd", 19, 9 220 112 72, tab 1
  radio "na janela ativa", 20, 15 240 91 13, tab 1, group
  radio "em outra janela", 21, 15 256 91 13, tab 1
  radio "no status", 22, 15 272 91 13, tab 1
  box "notices / snotices", 23, 125 220 112 72, tab 1, group
  radio "na janela ativa", 24, 135 240 91 13, tab 1
  radio "em outra janela", 25, 135 256 91 13, tab 1
  radio "no status", 26, 135 272 91 13, tab 1
  box "ao conectar...", 142, 242 144 180 72, tab 1
  check "auto-identificar", 143, 252 164 91 13, tab 1
  button "...", 144, 345 162 20 15, tab 1
  check "auto-join", 145, 252 180 91 13, tab 1
  box "ao entrar em um canal...", 146, 242 220 180 55, tab 1
  check "enviar msg", 147, 252 240 70 13, tab 1
  edit "", 148, 330 238 85 18, autohs tab 1
  check "mostrar status", 149, 252 256 90 13, tab 1
  check "auto-colocar foto no pvt", 150, 252 278 135 13, tab 1
  button "...", 151, 390 278 30 15, tab 1

  text "Configure aqui o que vc gostaria que o script fizesse quando você ficar away", 27, 7 140 371 13, tab 2
  check "Trocar de nick", 28, 8 161 91 13, tab 2
  combo 29, 97 161 200 100, drop edit size tab 2
  check "Logar", 30, 8 181 91 13, tab 2
  check "Pager", 31, 8 201 51 13, tab 2
  text "uin (icq #) --->", 32, 11 221 75 13, tab 2
  edit "", 33, 96 215 201 20, autohs tab 2
  text "e-mail        --->", 34, 11 241 75 13, tab 2
  edit "", 35, 96 235 201 20, autohs tab 2
  check "auto-away", 36, 8 261 71 13, tab 2
  edit "", 37, 96 255 145 20, autohs tab 2
  text "segundos", 38, 248 261 47 13, tab 2
  text "O nick completion faz com que vc precise digitar apenas uma parte do nick para falar com a pessoa. Ex.: MrP: oieeee  --->  MrPrompt: oieeee", 39, 8 137 411 25, tab 3
  radio "", 40, 9 167 15 13, tab 3, group
  icon 41, 25 165 103 16, $shortfn(script\img\1.jpg), tab 3
  radio "", 42, 9 183 15 13, tab 3
  icon 43, 25 181 103 16, $shortfn(script\img\2.jpg), tab 3
  radio "", 44, 9 199 15 13, tab 3
  icon 45, 25 197 103 16, $shortfn(script\img\3.jpg), tab 3
  radio "", 46, 9 215 15 13, tab 3
  icon 47, 25 213 103 16, $shortfn(script\img\4.jpg), tab 3
  radio "", 48, 9 231 15 13, tab 3
  icon 49, 25 229 103 16, $shortfn(script\img\5.jpg), tab 3
  radio "", 50, 9 247 15 13, tab 3
  icon 51, 25 245 103 16, $shortfn(script\img\6.jpg), tab 3
  radio "", 52, 9 263 15 13, tab 3
  icon 53, 25 261 103 16, $shortfn(script\img\7.jpg), tab 3
  radio "", 54, 9 279 15 13, tab 3
  icon 55, 25 277 103 16, $shortfn(script\img\8.jpg), tab 3
  radio "", 56, 9 295 15 13, tab 3
  icon 57, 25 293 103 16, $shortfn(script\img\9.jpg), tab 3
  radio "", 58, 137 167 15 13, tab 3
  icon 59, 153 165 103 16, $shortfn(script\img\10.jpg), tab 3
  radio "", 60, 137 183 15 13, tab 3
  icon 61, 153 181 103 16, $shortfn(script\img\11.jpg), tab 3
  radio "", 62, 137 199 15 13, tab 3
  icon 63, 153 197 103 16, $shortfn(script\img\12.jpg), tab 3
  radio "", 64, 137 215 15 13, tab 3
  icon 65, 153 213 103 16, $shortfn(script\img\13.jpg), tab 3
  radio "", 66, 137 231 15 13, tab 3
  icon 67, 153 229 103 16, $shortfn(script\img\14.jpg), tab 3
  radio "", 68, 137 247 15 13, tab 3
  icon 69, 153 245 103 16, $shortfn(script\img\15.jpg), tab 3
  radio "", 70, 137 263 15 13, tab 3
  icon 71, 153 261 103 16, $shortfn(script\img\16.jpg), tab 3
  radio "", 72, 137 279 15 13, tab 3
  icon 73, 153 277 103 16, $shortfn(script\img\17.jpg), tab 3
  radio "", 74, 137 295 15 13, tab 3
  icon 75, 153 293 103 16, $shortfn(script\img\18.jpg), tab 3
  box "", 76, 261 158 164 150, tab 3
  text "Selecione um estilo", 77, 269 171 147 13, tab 3
  radio "Padrão", 78, 268 187 59 13, tab 3, group
  radio "Aleatório", 79, 268 202 63 13, tab 3
  radio "Personalizado", 80, 268 216 87 13, tab 3
  text "Início  -->", 81, 269 262 47 13, tab 3
  edit "", 82, 316 256 105 20, autohs tab 3
  text "Fim      -->", 83, 269 287 47 13, tab 3
  edit "", 84, 316 280 105 20, autohs tab 3
  text "Cor do texto", 85, 7 139 67 13, tab 4
  icon 86, 9 156 19 19,  $shortfn(script\img\0.bmp), tab 4
  icon 87, 29 156 19 19, $shortfn(script\img\1.bmp), tab 4
  icon 88, 49 156 19 19, $shortfn(script\img\2.bmp), tab 4
  icon 89, 69 156 19 19, $shortfn(script\img\3.bmp), tab 4
  icon 90, 89 156 19 19, $shortfn(script\img\4.bmp), tab 4
  icon 91, 109 156 19 19, $shortfn(script\img\5.bmp), tab 4
  icon 92, 129 156 19 19, $shortfn(script\img\6.bmp), tab 4
  icon 93, 149 156 19 19, $shortfn(script\img\7.bmp), tab 4
  icon 94, 169 156 19 19, $shortfn(script\img\8.bmp), tab 4
  icon 95, 189 156 19 19, $shortfn(script\img\9.bmp), tab 4
  icon 96, 209 156 19 19, $shortfn(script\img\10.bmp), tab 4
  icon 97, 229 156 19 19, $shortfn(script\img\11.bmp), tab 4
  icon 98, 249 156 19 19, $shortfn(script\img\12.bmp), tab 4
  icon 99, 269 156 19 19, $shortfn(script\img\13.bmp), tab 4
  icon 100, 289 156 19 19, $shortfn(script\img\14.bmp), tab 4
  icon 101, 309 156 19 19, $shortfn(script\img\15.bmp), tab 4
  text "Cor de fundo", 102, 7 183 67 13, tab 4
  icon 103, 9 200 19 19, $shortfn(script\img\0.bmp), tab 4
  icon 104, 29 200 19 19, $shortfn(script\img\1.bmp), tab 4
  icon 105, 49 200 19 19, $shortfn(script\img\2.bmp), tab 4
  icon 106, 69 200 19 19, $shortfn(script\img\3.bmp), tab 4
  icon 107, 89 200 19 19, $shortfn(script\img\4.bmp), tab 4
  icon 108, 109 200 19 19, $shortfn(script\img\5.bmp), tab 4
  icon 109, 129 200 19 19, $shortfn(script\img\6.bmp), tab 4
  icon 110, 149 200 19 19, $shortfn(script\img\7.bmp), tab 4
  icon 111, 169 200 19 19, $shortfn(script\img\8.bmp), tab 4
  icon 112, 189 200 19 19, $shortfn(script\img\9.bmp), tab 4
  icon 113, 209 200 19 19, $shortfn(script\img\10.bmp), tab 4
  icon 114, 229 200 19 19, $shortfn(script\img\11.bmp), tab 4
  icon 115, 249 200 19 19, $shortfn(script\img\12.bmp), tab 4
  icon 116, 269 200 19 19, $shortfn(script\img\13.bmp), tab 4
  icon 117, 289 200 19 19, $shortfn(script\img\14.bmp), tab 4
  icon 118, 309 200 19 19, $shortfn(script\img\15.bmp), tab 4
  text "Para que você possa escrever colorido em canais, pvt's e chats, é necessário habilitar aqui o suporte, escolha tb a cor de fundo e de texto.", 119, 329 137 96 176, tab 4
  text "Texto  -->", 120, 9 233 51 13, tab 4
  text "Fundo -->", 121, 9 257 51 13, tab 4
  icon 122, 61 228 19 19, $shortfn(script\img\15.bmp), tab 4
  icon 123, 61 252 19 19, $shortfn(script\img\15.bmp), tab 4
  radio "Ativar auto-cor", 124, 11 287 91 13, tab 4, group
  radio "Desativar auto-cor", 125, 111 287 111 13, tab 4
  text "Configure aqui caso vc queira uma resposta diferente para os diversos eventos ctcp's", 126, 7 136 411 13, tab 5
  text "Ping", 127, 8 159 55 13, tab 5
  edit "", 128, 64 156 353 20, autohs tab 5
  text "Clientinfo", 129, 8 183 55 13, tab 5
  edit "", 130, 64 180 353 20, autohs tab 5
  text "Userinfo", 131, 8 207 55 13, tab 5
  edit "", 132, 64 204 353 20, autohs tab 5
  text "Finger", 133, 8 231 55 13, tab 5
  edit "", 134, 64 228 353 20, autohs tab 5
  text "Echo", 135, 8 255 55 13, tab 5
  edit "", 136, 64 252 353 20, autohs tab 5
  radio "Responder como indicado acima", 137, 9 296 179 13, tab 5, group
  radio "Não responder como indicado acima", 138, 197 296 199 13, tab 5
  edit "", 139, 4 136 422 174, multi vsbar tab 6

  text "char / nc", 140, 269 237 47 13, tab 3
  edit "", 141, 316 232 105 20, autohs tab 3
}

on *:dialog:dlgconfig:init:0:{
  var %nc = $readini(script\options.ini,nc,nc)
  var %char = $readini(script\options.ini,nc,char)
  var %estilo = $readini(script\options.ini,nc,estilo)

  if ($isfile(iee-readme.txt)) .loadbuf -o $dname 139 iee-readme.txt
  else did -a $dname 139 Arquivo de readme não existente....
  did -a dlgconfig 29 -Away
  did -a dlgconfig 29 [Away]
  did -a dlgconfig 29 [off]
  did -a dlgconfig 29 [0ff]
  did -a dlgconfig 29  AuEi
  did -a dlgconfig 29 away
  did -a dlgconfig 29 -f0r4
  did -a dlgconfig 29 FoRa

  if ($readini(script\options.ini,others,whois) == ativa) .did -c $dname 12
  elseif ($readini(script\options.ini,others,whois) == separada) .did -c $dname 13
  else .did -c $dname 14

  if ($readini(script\options.ini,others,names) == ativa) .did -c $dname 16
  elseif ($readini(script\options.ini,others,names) == status) .did -c $dname 17
  else .did -c $dname 18

  if ($readini(script\options.ini,others,motd) == ativa) .did -c $dname 20
  elseif ($readini(script\options.ini,others,motd) == separada) .did -c $dname 21
  else .did -c $dname 22

  if ($readini(script\options.ini,others,notices) == ativa) .did -c $dname 24
  elseif ($readini(script\options.ini,others,notices) == separada) .did -c $dname 25
  else .did -c $dname 26

  if ($readini script\options.ini away autoaway == yes) .did -c dlgconfig 36
  else .did -u dlgconfig 36
  .did -a dlgconfig 37 $readini script\options.ini away auto-secs
  .did -a dlgconfig 35 $readini script\options.ini away mail
  .did -a dlgconfig 33 $readini script\options.ini away uin

  if ($readini(script\options.ini,away,nick) == 1) .did -c dlgconfig 28
  if ($readini(script\options.ini,away,log) == 1) .did -c dlgconfig 30
  if ($readini(script\options.ini,away,page) == 1) .did -c dlgconfig 31

  if (%nc == 1) .did -c dlgconfig 40
  elseif (%nc == 2) .did -c dlgconfig 42
  elseif (%nc == 3) .did -c dlgconfig 44
  elseif (%nc == 4) .did -c dlgconfig 46
  elseif (%nc == 5) .did -c dlgconfig 48
  elseif (%nc == 6) .did -c dlgconfig 50
  elseif (%nc == 7) .did -c dlgconfig 52
  elseif (%nc == 8) .did -c dlgconfig 54
  elseif (%nc == 9) .did -c dlgconfig 56
  elseif (%nc == 10) .did -c dlgconfig 58
  elseif (%nc == 11) .did -c dlgconfig 60
  elseif (%nc == 12) .did -c dlgconfig 62
  elseif (%nc == 13) .did -c dlgconfig 64
  elseif (%nc == 14) .did -c dlgconfig 66
  elseif (%nc == 15) .did -c dlgconfig 68
  elseif (%nc == 16) .did -c dlgconfig 70
  elseif (%nc == 17) .did -c dlgconfig 72
  else .did -c dlgconfig 74

  if (%estilo == padrao) .did -c dlgconfig 78
  elseif (%estilo == random) .did -c dlgconfig 79
  else .did -c dlgconfig 80

  .did -a dlgconfig 82 %nc.inicio
  .did -a dlgconfig 84 %nc.fim
  .did -a $dname 141 %char

  if (%saycolor) .did -c dlgconfig 124
  else .did -c dlgconfig 125
  if ($gettok(%saycolor,1,44)) .did -g $dname 122 script\img\ $+ $gettok(%saycolor,1,44) $+ .bmp ;cor de texto
  if ($gettok(%saycolor,2,44)) .did -g $dname 123 script\img\ $+ $gettok(%saycolor,2,44) $+ .bmp ;cor de fundo

  .did -a dlgconfig 128 $readini(script\options.ini,ctcp,ping)
  .did -a dlgconfig 130 $readini(script\options.ini,ctcp,clientinfo)
  .did -a dlgconfig 132 $readini(script\options.ini,ctcp,userinfo)
  .did -a dlgconfig 134 $readini(script\options.ini,ctcp,finger)
  .did -a dlgconfig 136 $readini(script\options.ini,ctcp,echo)

  if ($readini(script\options.ini,ctcp,ctcp) == proprio) .did -c dlgconfig 137
  else .did -c dlgconfig 138

  if ($readini(script\options.ini,others,autoidentify) == 1) .did -c $dname 143
  if ($group(#autojoin) == on) .did -c $dname 145
  if (%join.msg != $null) { .did -a $dname 148 %join.msg | .did -c $dname 147 }
  if ($readini(script\options.ini,others,join.status) == 1) .did -c $dname 149

  if ($readini(script\options.ini,others,foto-pvt) == 1) .did -c $dname 150
}

on *:dialog:dlgconfig:sclick:7: {
  if ($did(12).state) .writeini -n script\options.ini others whois ativa
  elseif ($did(13).state) .writeini -n script\options.ini others whois separada
  else .writeini -n script\options.ini others whois dialog

  if ($did(16).state) .writeini -n script\options.ini others names ativa
  elseif ($did(17).state) .writeini -n script\options.ini others names status
  else .writeini -n script\options.ini others names hide

  if ($did(20).state) .writeini -n script\options.ini others motd ativa
  elseif ($did(21).state) .writeini -n script\options.ini others motd separada
  else .writeini -n script\options.ini others motd status

  if ($did(24).state) .writeini -n script\options.ini others notices ativa
  elseif ($did(25).state) .writeini -n script\options.ini others notices separada
  else .writeini -n script\options.ini others notices status

  if ($did(28).state) { 
    .writeini -n script\options.ini away nick $did(28).state
    if ($did(29).text != $null) { .writeini -n script\options.ini away nickaway $did(29).text }
  }
  else { .writeini -n script\options.ini away nick $did(28).state }
  .writeini -n script\options.ini away log $did(30).state
  .writeini -n script\options.ini away page $did(31).state
  if ($did(36).state) { .writeini script\options.ini away autoaway yes | .timer666 0 1 autoaway }
  else { .timer666 off | .writeini script\options.ini away autoaway no }
  if ($did(33).text != $null) { .writeini script\options.ini away uin $did(33).text }
  if ($did(35).text != $null) { .writeini script\options.ini away mail $did(35).text }
  if ($did(37).text != $null) { .writeini script\options.ini away auto-secs $did(37).text }

  if ($did(40).state) .writeini -n script\options.ini nc nc 1
  elseif ($did(42).state) .writeini -n script\options.ini nc nc 2
  elseif ($did(44).state) .writeini -n script\options.ini nc nc 3
  elseif ($did(46).state) .writeini -n script\options.ini nc nc 4
  elseif ($did(48).state) .writeini -n script\options.ini nc nc 5
  elseif ($did(50).state) .writeini -n script\options.ini nc nc 6
  elseif ($did(52).state) .writeini -n script\options.ini nc nc 7
  elseif ($did(54).state) .writeini -n script\options.ini nc nc 8
  elseif ($did(56).state) .writeini -n script\options.ini nc nc 9
  elseif ($did(58).state) .writeini -n script\options.ini nc nc 10
  elseif ($did(60).state) .writeini -n script\options.ini nc nc 11
  elseif ($did(62).state) .writeini -n script\options.ini nc nc 12
  elseif ($did(64).state) .writeini -n script\options.ini nc nc 13
  elseif ($did(66).state) .writeini -n script\options.ini nc nc 14
  elseif ($did(68).state) .writeini -n script\options.ini nc nc 15
  elseif ($did(70).state) .writeini -n script\options.ini nc nc 16
  elseif ($did(72).state) .writeini -n script\options.ini nc nc 17
  else .writeini -n script\options.ini nc nc 18
  if ($did(78).state) .writeini -n script\options.ini nc estilo padrao
  elseif ($did(79).state) .writeini -n script\options.ini nc estilo random
  else .writeini -n script\options.ini nc estilo proprio
  if ($did(141).text != $null) .writeini -n script\options.ini nc char $did(141).text
  if ($did(82).text != $null) .set %nc.inicio $did(82).text
  if ($did(84).text != $null) .set %nc.fim $did(84).text

  if (%_saycolor) || (%_saycolor²) && ($did(124).state) .set %saycolor %_saycolor $+ , $+ %_saycolor²
  elseif ($did(125).state) .unset %saycolor
  else .unset %saycolor

  if ($did(128).text != $null) .writeini -n script\options.ini ctcp ping $did(128).text
  if ($did(130).text != $null) .writeini -n script\options.ini ctcp clientinfo $did(130).text
  if ($did(132).text != $null) .writeini -n script\options.ini ctcp userinfo $did(132).text
  if ($did(134).text != $null) .writeini -n script\options.ini ctcp finger $did(134).text
  if ($did(136).text != $null) .writeini -n script\options.ini ctcp echo $did(136).text

  if ($did(137).state) .writeini -n script\options.ini ctcp ctcp proprio
  else .writeini -n script\options.ini ctcp ctcp padrao

  .writeini -n script\options.ini others join.status $did(149).state
  if ($did(147).state) && ($did(148) != $null) .set %join.msg $did(148).text
  else .unset %join.msg
  .writeini -n script\options.ini others autoidentify $did(143).state
  .writeini -n script\options.ini others foto-pvt $did(150).state
}
on *:dialog:dlgconfig:sclick:86:set %_saycolor 0 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:87:set %_saycolor 1 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:88:set %_saycolor 2 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:89:set %_saycolor 3 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:90:set %_saycolor 4 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:91:set %_saycolor 5 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:92:set %_saycolor 6 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:93:set %_saycolor 7 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:94:set %_saycolor 8 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:95:set %_saycolor 9 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:96:set %_saycolor 10 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:97:set %_saycolor 11 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:98:set %_saycolor 12 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:99:set %_saycolor 13 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:100:set %_saycolor 14 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:101:set %_saycolor 15 | did -g dlgconfig 122 script\img\ $+ %_saycolor $+ .bmp
on *:dialog:dlgconfig:sclick:103:set %_saycolor² 0 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:104:set %_saycolor² 1 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:105:set %_saycolor² 2 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:106:set %_saycolor² 3 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:107:set %_saycolor² 4 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:108:set %_saycolor² 5 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:109:set %_saycolor² 6 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:110:set %_saycolor² 7 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:111:set %_saycolor² 8 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:112:set %_saycolor² 9 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:113:set %_saycolor² 10 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:114:set %_saycolor² 11 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:115:set %_saycolor² 12 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:116:set %_saycolor² 13 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:117:set %_saycolor² 14 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:118:set %_saycolor² 15 | did -g dlgconfig 123 script\img\ $+ %_saycolor² $+ .bmp
on *:dialog:dlgconfig:sclick:144:.ai
on *:dialog:dlgconfig:sclick:145:if ($did(145).state) .enable #autojoin | else .disable #autojoin
on *:dialog:dlgconfig:sclick:151:.timer 1 0 .writeini -n script\options.ini others fotos-dir $$sdir(c:\*.jpg,Selecione o diretório de suas fotos)
; eof
