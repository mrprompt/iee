; -- iee script - proteção de canal by MrPrompt
; - propaganda no canal
alias prot2 { if (!$dialog(prot2)) .dialog -m prot2 prot2 }
dialog prot2 {
  title $strip($gettok($ver,1,32)) - Anti-Propaganda no canal
  size -1 -1 424 229
  icon script\iee2.ico

  ; - palavras
  box "", 1, 2 1 141 224
  text "Palavras", 2, 11 15 47 13
  list 3, 8 32 130 166, size
  button "Add", 4, 10 201 45 18
  button "Del", 5, 58 201 45 18

  ; - canais
  box "", 6, 146 1 141 224
  text "Canais", 7, 155 15 39 13
  list 8, 152 32 130 166, size
  button "Add", 9, 154 201 45 18
  button "Del", 10, 202 201 45 18

  ; - ação
  box "", 11, 290 1 129 120
  text "Ação", 12, 299 15 31 13
  radio "kickar", 13, 297 36 75 13, group
  radio "banir e kickar", 14, 297 56 83 13
  text "Mensagem de kick", 15, 299 79 95 13
  edit "", 16, 299 97 113 20, autohs

  check "ativar proteção", 17, 290 126 100 13

  button "&Gravar", 18, 290 170 128 25, ok
  button "&Sair", 19, 290 199 128 25, cancel
}
on *:dialog:prot2:init:0:{
  `list
  if ($readini(script\options.ini,propaganda,acao) == kick) { did -c $dname 13 } | else { did -c $dname 14 }
  did -ra $dname 16 $readini(script\options.ini,propaganda,msg)
  if ($readini(script\options.ini,propaganda,stat) == 1) { 
    did -c $dname 17
    did -e $dname 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
  }
  else {
    did -u $dname 17
    did -b $dname 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
  }
}
on *:dialog:prot2:sclick:4:{
  var %palavras $readini(script\options.ini,propaganda,palavras)
  .writeini -n script\options.ini propaganda palavras %palavras $+ $entry(Proibir quais palavras:) $+ ,
  `list
}
on *:dialog:prot2:sclick:5:{
  var %palavras $readini(script\options.ini,propaganda,palavras)
  var %palavras2 $deltok(%palavras,$did(3).sel,44)
  .writeini -n script\options.ini propaganda palavras %palavras2 $+ ,
  `list
}
on *:dialog:prot2:sclick:9:{
  var %chans $readini(script\options.ini,propaganda,canais)
  .writeini -n script\options.ini propaganda canais %chans $+ $entry(Adicionar canal (com #):) $+ ,
  `list
}
on *:dialog:prot2:sclick:10:{
  var %chans $readini(script\options.ini,propaganda,canais)
  var %chans2 $deltok(%chans,$did(8).sel,44)
  .writeini -n script\options.ini propaganda canais %chans2 $+ ,
  `list
}
on *:dialog:prot2:sclick:13:.writeini -n script\options.ini propaganda acao kick
on *:dialog:prot2:sclick:14:.writeini -n script\options.ini propaganda acao kickban
on *:dialog:prot2:edit:16:if ($did(16).text != $null) { .writeini -n script\options.ini propaganda msg $did(16).text }
on *:dialog:prot2:sclick:17:{
  if ($did(17).state) {
    .writeini -n script\options.ini propaganda stat 1 
    did -e $dname 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
  }
  else { 
    .writeini -n script\options.ini propaganda stat 0
    did -b $dname 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
  }
}
alias -l `list {
  did -r $dname 3,8
  var %x 0
  var %y 0
  while (%x < $numtok($readini(script\options.ini,propaganda,canais),44)) { inc %x | did -a prot2 8 $gettok($readini(script\options.ini,propaganda,canais),%x,44) }
  while (%y < $numtok($readini(script\options.ini,propaganda,palavras),44)) { inc %y | did -a prot2 3 $gettok($readini(script\options.ini,propaganda,palavras),%y,44) }
}
on @*:text:*:#:{
  var %_canais = $readini(script\options.ini,propaganda,canais)
  var %_stat   = $readini(script\options.ini,propaganda,stat)
  var %_msg    = $readini(script\options.ini,propaganda,msg)
  var %_prop   = $readini(script\options.ini,propaganda,palavras)
  if (%_stat == 1) && ($chan isin %_canais) {
    var %tmp = 1
    while ($gettok(%_prop,%tmp,44) !=  $null) {
      if ($gettok(%_prop,%tmp,44) isin $strip($1-)) { 
        if ($readini(script\options.ini,propaganda,acao) == kickban) { .kb $nick %_msg | halt }
        else { .kick # $nick %_msg | halt }
      }
      inc %tmp
    }
  }
}
;eof
