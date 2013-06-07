; -- iee script - eventos raw
;
; connect messages
raw 001:*:echo $colour(info) -tms $x $2- | halt
raw 002:*:echo $colour(info) -tms $x $2- | halt
raw 003:*:echo $colour(info) -tms $x $2- | halt
raw 004:*:echo $colour(info) -tms $x $2- | halt
raw 005:*:echo $colour(info) -tms $x $2- | halt

; lusers
raw 250:*:echo $colour(info) -tms $x $2- | echo $colour(info) -tms $x $sep | halt
raw 251:*:echo $colour(info) -tms $x $sep | echo $colour(info) -tms $x $2- | halt
raw 252:*:echo $colour(info) -tms $x $2- | halt
raw 253:*:echo $colour(info) -tms $x $2- | halt
raw 254:*:echo $colour(info) -tms $x $2- | halt
raw 255:*:echo $colour(info) -tms $x $2- | halt
raw 256:*:echo $colour(info) -tms $x $2- | halt
raw 265:*:echo $colour(info) -tms $x $2- | halt
raw 266:*:echo $colour(info) -tms $x $2- | halt
; names 
raw 353:*:{
  var %me $me
  var %me_  $+ $colour(notify) $+ $me $+ 
  var %op  $+ $colour(kick) $+ $chr(64) $+ 
  var %voice  $+ $colour(ctcp text) $+ $chr(43) $+ 
  goto $readini(script\options.ini,others,names)
  :ativa | echo $colour(info) -tml $3 $x $replace($4-,$chr(64), %op ,$chr(43), %voice ,%me,%me_) | halt
  :status | echo $colour(info) -tms $x $replace($4-,$chr(64), %op ,$chr(43), %voice ,%me,%me_) | halt
  :hide | halt
}
raw 366:*:{
  goto $readini(script\options.ini,others,names)
  :hide | halt
  :ativa | halt
  :status | echo $colour(info) -tms $x end of names | halt
}

; motd
raw 372:*:{ 
  var %motd = $readini(script\options.ini,others,motd)
  if ($motd == 0) { 
    if (%motd == separada) { 
      .window -lkv +l @motd
      aline @motd $x  $+ $colour(notice text) $2- $+  
      .titlebar @motd of $server - $network 
      halt 
    }
    if (%motd == status) { echo $colour(notice text) -tms $x $2- | halt } 
    if (%motd == ativa) { echo $colour(notice text) -tma $x $2- | halt } 
  }
  else { halt } 
}
raw 375:*:{
  var %motd = $readini(script\options.ini,others,motd)
  if ($motd == 0) { 
    if (%motd == separada) { 
      .window -lkv +l @motd
      .aline @motd $x  $+ $colour(notice text) $2- $+ 
      .titlebar @motd of $server - $network
      halt 
    }
    if (%motd == status) { echo $colour(notice text) -tms $x $2- | halt }
    if (%motd == ativa) { echo $colour(notice text) -tma $x $2- | halt } 
  }
  else { halt } 
}
raw 376:*:halt
raw 377:*:{
  var %motd = $readini(script\options.ini,others,motd)
  if ($motd == 0) { 
    if (%motd == separada) { 
      ..window -lkv +l @motd
      .aline @motd $x  $+ $colour(notice text) $2- $+  
      .titlebar @motd of $server - $network
      halt 
    }
    if (%motd == status) { echo $colour(notice text) -tms $x $2- | halt }
    if (%motd == ativa) { echo $colour(notice text) -tma $x $2- | halt } 
  }
  else { halt } 
}
raw 378:*:{ 
  var %motd = $readini(script\options.ini,others,motd)
  if ($motd == 0) { 
    if (%motd == separada) { 
      .window -lkv +l @motd
      .aline @motd $x  $+ $colour(notice text) $2- $+ 
      .titlebar @motd of $server - $network
      halt 
    }
    if (%motd == status) { echo $colour(notice text) -tms $x $2- | halt }
    if (%motd == ativa) { echo $colour(notice text) -tma $x $2- | halt } 
  }
  else { halt } 
}

; whois display
alias whois {
  .set %_nick  $+ $1 $+ 
  goto $readini(script\options.ini,others,whois)
  :dialog | if ($dialog(whois)) .whois $1- | else { dialog -m whois whois | .whois $1- } | return
  :separada | .window -e @whois script\iee2.ico | .whois $1- | .timer 1 0 editbox -p @whois /whois | return
  :ativa | .whois $1- | return
}
raw 301:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : away: $3- | halt
  :dialog | if ($dialog(whois)) { did -r whois 14 | did -a whois 14 $3- } | halt
  :separada | if ($window(@whois)) aline @whois $x  $+ $colour(background) %_nick $+  : away: $3- | halt
}
raw 311:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $2 $+  : $3 $+ @ $+ $4 | echo $colour(whois) -tma $x  $+ $colour(background)  $+ $2 $+  : $6- | halt 
  :dialog | did -r whois 4,8,2 | did -a whois 4 $2 | did -a whois 8 $3 $+ @ $+ $4 | did -a whois 2 $6- | halt
  :separada | aline @whois $sep | aline @whois $x  $2 $+  : $3 $+ @ $+ $4 | aline @whois $x  $+ $colour(background)  $+ $2 $+  :  $6- | halt
}
raw 312:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | did -r whois 6 | did -a whois 6 $3- | halt
  :separada | if ($window(@whois)) aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 307:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | if ($strip(reg) isin $2-) did -c whois 15 |  halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 308:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | echo $colour(whois) -tms $x  $+ $colour(background) %_nick $+  : $3- | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 309:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | echo $colour(whois) -tms $x  $+ $colour(background) %_nick $+  : $3- | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 310:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 313:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
raw 317:*:{ 
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : Idle: $duration($3) | halt 
  :dialog | did -r whois 10 | did -a whois 10 $duration($3) | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : Idle: $duration($3) | halt 
}
raw 318:*:halt
raw 319:*:{
  goto $readini(script\options.ini,others,whois)
  :ativa | echo $colour(whois) -tma $x  $+ $colour(background) %_nick $+  : $3- | halt 
  :dialog | did -r whois 12 | did -a whois 12 $3- | halt
  :separada | aline @whois $x  $+ $colour(background) %_nick $+  : $3- | halt 
}
;
dialog whois {
  title "Whois"
  size -1 -1 340 120
  icon script\iee2.ico
  text "nome:", 1, 5 5 28 15
  edit "", 2, 35 1 100 20, autohs
  text "nick:", 3, 138 5 40 15
  edit "", 4, 162 1 100 20, autohs
  text "servidor:", 5, 5 25 50 15
  edit "", 6, 45 20 217 20, autohs
  text "host:", 7, 22 45 22 15
  edit "", 8, 45 39 130 20, autohs
  text "idle:", 9, 180 45 30 15
  edit "", 10, 200 39 62 20, autohs
  text "canais:", 11, 5 65 40 15
  edit "", 12, 45 60 217 20, autohs
  text "msg de away:", 13, 5 85 65 15
  edit "", 14, 71 80 191 20, autohs
  check "nick registrado", 15, 5 105 90 15
  button "&whois", 17, 265 3 70 17
  button "&uwho", 18, 265 20 70 17
  button "&ping", 19, 265 37 70 17
  button "&dns", 20, 265 54 70 17
  button "&fechar", 99, 265 102 70 17, cancel
  button "&ok", 999, 0 0 0 0, ok hide
}
on *:dialog:whois:sclick:17:whois $did(whois,4).text
on *:dialog:whois:sclick:18:uwho $did(whois,4).text
on *:dialog:whois:sclick:19:ping $did(whois,4).text
on *:dialog:whois:sclick:20:dns $did(whois,4).text
;
; other raws
raw 219:*:echo $colour(info) -tms $x End of /stats report | halt
raw 256:*:echo $colour(info) -tms $x %b.e $+ $server $+ %b.d $5 | halt
raw 257:*:echo $colour(info) -tms $x %b.e $+ $server $+ %b.d $2- | halt
raw 258:*:echo $colour(info) -tms $x %b.e $+ $server $+ %b.d $2- | halt
raw 259:*:echo $colour(info) -tms $x %b.e $+ $server $+ %b.d $2- | halt
raw 314:*:set %_nick $2 | echo $colour(info) -tms $x  $+ $2 $+  whowas - $3 $+ @ $+ $4 | echo $colour(info) -tms $x name: $6- | echo $colour(info) -tms $x end of whowas | halt
raw 315:*:echo $colour(info) -tms $x end of /who list | halt
raw 323:*:haltdef | echo $colour(info) -tms $x end of /list | halt
raw 324:*:if ($me ison $2) && ($readini(script\options.ini,others,join.status) == 1) { echo $colour(own) -tml $2 $x %b.e $+  $+ $colour(info text) $+ $2 $+  $+ %b.d ops: ( $+ $nick($2,0,o) - $percent($nick($2,0,o),$nick($2,0)) $+ % $+ ) - voicers: ( $+ $nick($2,0,v) - $percent($nick($2,0,v),$nick($2,0)) $+ % $+ ) - normais: ( $+ $nick($2,0,r) - $percent($nick($2,0,r),$nick($2,0)) $+ % $+ ) - total: ( $+ $nick($2,0) $+ ) | halt }
raw 329:*:if ($readini(script\options.ini,others,join.status) == 1) { echo $colour(info) -tml $2 $x canal criado em: $asctime($3) } | halt
raw 331:*:echo $colour(topic) -tml $2 $x não há tópico no $2 | halt
raw 332:*:echo $colour(topic) -tml $2 $x %b.e $+ $2 $+ %b.d $+ .topic : $3- | halt
raw 333:*:echo $colour(topic) -tml $2 $x %b.e $+ $2 $+ %b.d $+ .topic by: $3 | halt
raw 341:*:echo $colour(info) -tma $x $2 foi convidado ao $3 | halt
raw 351:*:echo $colour(info) -tms $x servidor: $3 - versão: $2 | halt
raw 365:*:echo $colour(info) -tms $x End of /links list | halt
raw 367:*:echo $colour(kick) -tma $x %b.e $+ $2 $+ %b.d $3 banido por: $4 | halt
raw 368:*:echo $colour(info) -tma $x %b.e $+ $2 $+ %b.d fim da lista de ban. | halt
raw 369:*:halt
raw 391:*:echo $colour(info) -tms $x Data: $3 $+ , $+ $5 de $4 de $6 | echo $colour(info) -tms $x time: $8 ( $+ $9 $+ ) | halt
raw 401:*:echo $colour(info) -tma $x %b.e $+ $2 $+ %b.d apelido/canal inexistente. | if ($dialog(whois)) { dialog -c whois whois } | if ($window(@whois)) { .aline @whois $x %b.e $+ $2 $+ %b.d apelido/canal inexistente. } | halt
raw 402:*:echo $colour(info) -tma $x Não é possível achar o servidor.
raw 403:*:halt
raw 404:*:echo $colour(kick) -tma %b.e $+ $2 $+ %b.d Não é possível enviar mensagem. | halt
raw 405:*:echo $colour(kick) -tma $x Você já está em muitos canais | halt
raw 406:*:echo $colour(kick) -tma $x o nick  $+ $2 $+  não esteve no irc | halt
raw 409:*:echo $colour(kick) -tma $x origem não especificada | halt
raw 412:*:echo $colour(kick) -tma $x sem texto para enviar | halt
raw 421:*:echo $colour(kick) -tma $x / $+ $2 $+  comando desconhecido | halt
raw 422:*:echo $colour(kick) -tma $x Erro retornando arquivo de motd do servidor. | halt
raw 431:*:echo $colour(kick) -tma $x nick não existente | if ($dialog(whois)) { dialog -c whois whois } | if ($window(@whois)) aline @whois $x nick não existente. | halt
raw 432:*:echo $colour(info) -tma $x o nick $2 contém caracteres ilegais. | halt
raw 433:*:echo $colour(kick) -tma $x o nick $2 já em está sendo utilizado. Tente outro. | halt
raw 436:*:echo $colour(kick) -tma $x Colisão de nick. | halt
raw 440:*:echo $colour(info) -tma $x $3- | halt
raw 441:*:echo $colour(kick) -tma $x %b.e $+ $2 $+ %b.d inexistente. | halt
raw 443:*:echo $colour(info) -tma $x %b.e $+ $2 $+ %b.d já existe $3 | halt
raw 455:*:echo $colour(kick) -tma $x o nick $4 contém caracteres inválidos: $9 | halt 
raw 461:*:echo $colour(kick) -tma $x $2 parâmetro insuficiente | halt
raw 464:*:echo $colour(kick) -tma $x Status de Operador negado (Senha inválida) | halt
raw 465:*:echo $colour(kick) -tms $x Você está banido deste servidor. | halt
raw 468:*:echo $colour(info) -tms $x ( $+ $2 $+ ) --> somente servers/ircops podem usar este(s) modo(s) | halt
raw 471:*:echo $colour(kick) -tms $x Impossível entrar no canal $2 - O canal está cheio. | halt
raw 472:*:echo $colour(kick) -tml # $x Modo de canal desconhecido: $2 | halt
raw 473:*:echo $colour(info) -tms $x o canal $2 é somente para convidados, você não pode entrar. | halt
raw 474:*:echo $colour(kick) -tms $x Você foi banido do canal $2 | halt
raw 475:*:echo $colour(kick) -tms $x para entrar no canal $2 é necessário uma senha. | halt
raw 477:*:echo $colour(kick) -tms $x o canal $2 é somente para nicks registrados. | halt
raw 478:*:echo $colour(info) -tms $x Sua lista de ignore está cheia, $2 não adicionado. | halt
raw 481:*:echo $colour(kick) -tms $x comando não autorizado. | halt
raw 482:*:echo $colour(kick) -tml $2 %b.e $+ $2 $+ %b.d Você não é um operador do canal. | halt
raw 501:*:echo $colour(info) -tma $x modo $2- desconhecido | halt
raw 502:*:echo $colour(kick) -tms $x Você não pode mudar o modo de outros usuários. | halt

; eof
