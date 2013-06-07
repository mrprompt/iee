; -- iee script - proteção de canal by Blaster
;- Proteções de texto
on @*:text:*:#: {
  if ($readini script\cfgprt.mrc #fld ld == 1) && ($chan isin $readini script\cfgprt.mrc #fld #s) {
    set %_#fld.ltm $readini script\temp\ $+ $nick $+ . $+ $chan #fld tm
    set %_#fld.dif $calc($ctime - %_#fld.ltm)
    if (%_#fld.dif > $readini script\cfgprt.mrc #fld lns) {
      writeini script\temp\ $+ $nick $+ . $+ $chan #fld lns 0
    }
    set %_#fld.lns $readini script\temp\ $+ $nick $+ . $+ $chan #fld lns
    inc %_#fld.lns
    writeini script\temp\ $+ $nick $+ . $+ $chan #fld lns %_#fld.lns
    if (%_#fld.lns >= $readini script\cfgprt.mrc #fld lns) && (%_#fld.dif <= $readini script\cfgprt.mrc #fld tm) {
      ^fldprtact $chan $nick #fld
      writeini script\temp\ $+ $nick $+ . $+ $chan #fld lns 0
    }
    writeini script\temp\ $+ $nick $+ . $+ $chan #fld tm $ctime
    unset %_#fld.*
  }
}
;- Alias para ação ao flooder
alias -l ^fldprtact {
  unset %_fldprtact.*
  if ($3 == $null) { goto end }
  set %_fldprtact.chn $1
  set %_fldprtact.nck $2
  set %_fldprtact.wht $3
  set %_fldprtact.msg $null
  ; :Verificar se existem ações ou se não há nenhuma ação configurada:
  if ($readini script\cfgprt.mrc %_fldprtact.wht a1 == $null) || ($readini script\cfgprt.mrc %_fldprtact.wht l1 == 0) {
    erro Você não configurou nenhuma ação para proteção ou estão todas desligadas.
    goto end
  }
  ; :Verificar qual número da ação o flooder receberá:
  set %_fldprtact.tm $readini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht tmua
  set %_fldprtact.dif $calc($ctime - %_fldprtact.tm)
  set %_fldprtact.tm $readini script\cfgprt.mrc act tm
  if (%_fldprtact.dif > %_fldprtact.tm) {
    set %_fldprtact.na 0
  }
  else {
    set %_fldprtact.na $readini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht ua
  }
  inc %_fldprtact.na
  if (%_fldprtact.na > 3) { set %_fldprtact.na 3 }
  :loop
  goto %_fldprtact.na
  :1 {
    set %_fldprtact.m m1 | set %_fldprtact.l l1 | set %_fldprtact.a a1 | goto next
  }
  :2 {
    set %_fldprtact.m m2 | set %_fldprtact.l l2 | set %_fldprtact.a a2 | goto next
  }
  :3 {
    set %_fldprtact.m m3 | set %_fldprtact.l l3 | set %_fldprtact.a a3 | goto next
  }
  :next
  if ($readini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht %_fldprtact.l == 0) {
    dec %_fldprtact.na
    goto loop
  }
  ; :Mensagem para ação:
  if ($readini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht %_fldprtact.m == rnd) {
    set %_fldprtact.msg $read $mircdirkicks.txt
  }
  else {
    set %_fldprtact.msg $readini script\cfgprt.mrc %_fldprtact.wht %_fldprtact.m
  }
  :loop&
  if (&nick& isin %_fldprtact.msg) {
    set %_fldprtact.msg.pos $pos(%_fldprtact.msg,&nick&,1)
    set %_fldprtact.msg $mid(%_fldprtact.msg,0,$calc(%_fldprtact.msg.pos - 1)) $+ $nick $+ $mid(%_fldprtact.msg,$calc(%_fldprtact.msg.pos + 6),$len(%_fldprtact.msg))
    goto loop&
  }
  if (&canal& isin %_fldprtact.msg) {
    set %_fldprtact.msg.pos $pos(%_fldprtact.msg,&canal&,1)
    set %_fldprtact.msg $mid(%_fldprtact.msg,0,$calc(%_fldprtact.msg.pos - 1)) $+ $chan $+ $mid(%_fldprtact.msg,$calc(%_fldprtact.msg.pos + 7),$len(%_fldprtact.msg))
    goto loop&
  }
  if (&endereço& isin %_fldprtact.msg) {
    set %_fldprtact.msg.pos $pos(%_fldprtact.msg,&endereço&,1)
    set %_fldprtact.msg $mid(%_fldprtact.msg,0,$calc(%_fldprtact.msg.pos - 1)) $+ $address($nick,0) $+ $mid(%_fldprtact.msg,$calc(%_fldprtact.msg.pos + 10),$len(%_fldprtact.msg))
    goto loop&
  }
  ; :Ver qual ação e executar:
  set %_fldprtact.act $readini script\cfgprt.mrc %_fldprtact.wht %_fldprtact.a
  goto %_fldprtact.act
  :kick {
    kick %_fldprtact.chn %_fldprtact.nck %_fldprtact.msg | goto gravar
  }
  :ban {
    ban %_fldprtact.chn %_fldprtact.nck | goto gravar
  }
  :kickban {
    kick %_fldprtact.chn %_fldprtact.nck %_fldprtact.msg
    ban %_fldprtact.chn %_fldprtact.nck | goto gravar
  }
  :tempban {
    ban -u $+ 600 %_fldprtact.chn %_fldprtact.nck | goto gravar
  }
  :msg {
    msg %_fldprtact.nck %_fldprtact.msg | goto gravar
  }
  :onotice {
    onotice %_fldprtact.chn %_fldprtact.msg | goto gravar
  }
  ; :gravar ação:
  :gravar
  writeini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht tmua $ctime
  writeini script\temp\ $+ %_fldprtact.nck $+ . $+ %_fldprtact.chn %_fldprtact.wht ua %_fldprtact.na
  :end
}
;- Dialog para configuração
dialog cfgprotect {
  title $strip($gettok($ver,1-3,32)) - Proteção contra flood no canal
  size -1 -1 248 167
  icon script\iee2.ico
  option type dbu

  box "Geral",1,2 1 150 52
  text "Mensagem padrão de kick:",11,5 10 50 20
  edit %_cfgprot.msg,21,56 11 90 11,autohs
  text "Tempo para retornar à primeira ação:",10,5 25 50 30
  edit %_cfgprot.acttm,20,56 27 20 11,right autohs
  text "segundos",13,78 29 25 10
  check "Mostrar número de kick",50,5 40 70 10,left

  button "OK",90,160 10 80 10,ok
  button "Cancelar",91,160 25 80 10,cancel

  box "Informações:",3,155 61 90 103
  text "Você pode utilizar códigos nas suas mensagens de kick (exceto padrão) para exibir valores correspondentes à ação:",14,158 69 87 27
  text "&&nick&& => corresponde ao nick",15,158 97 82 10
  text "&&canal&& => corresponde ao #canal",16,158 105 82 15
  text "&&endereço&& => corresponde ao endereço (mask) do user. Endereço no formato: *!user@host.domain",17,158 119 82 26

  box "",2,2 61 150 103
  check "Proteção de flood",51,5 54 60 10
  text "Canais para ativar: (Separe por vírgulas)",12,5 68 50 20
  edit %_cfgprot[flood].chan,22,56 70 90 11,autohs
  text "Kickar em",18,29 86 40 10
  edit %_cfgprot[flood].lns,23,56 83 15 11,right
  text "linhas em",19,73 86 30 10
  edit %_cfgprot[flood].tm,24,98 83 15 11,right
  text "segundos.",40,115 86 30 10
  check "Ação 1:",52,5 96 40 10
  combo 70,5 107 60 60,drop
  text "Mensagem:",41,70 98 80 10
  edit %_cfgprot[flood].m1,25,70 107 76 11,autohs
  check "Ação 2:",53,5 118 40 10
  combo 71,5 129 60 60,drop
  text "Mensagem:",42,70 120 80 10
  edit %_cfgprot[flood].m2,26,70 129 76 11,autohs
  check "Ação 3:",54,5 140 40 10
  combo 72,5 150 60 60,drop
  text "Mensagem:",43,70 142 80 10
  edit %_cfgprot[flood].m3,27,70 150 76 11,autohs
}
on *:dialog:cfgprotect:sclick:90:{
  writeini script\cfgprt.mrc kck msg $did(21).text | writeini script\cfgprt.mrc kck nmrshw $did(50).state
  writeini script\cfgprt.mrc act tm $did(20).text | writeini script\cfgprt.mrc #fld ld $did(51).state
  writeini script\cfgprt.mrc #fld #s $did(22).text | writeini script\cfgprt.mrc #fld lns $did(23).text
  writeini script\cfgprt.mrc #fld tm $did(24).text | writeini script\cfgprt.mrc #fld a1 $did(70).text
  writeini script\cfgprt.mrc #fld m1 $did(25).text | writeini script\cfgprt.mrc #fld l1 $did(52).state
  writeini script\cfgprt.mrc #fld a2 $did(71).text | writeini script\cfgprt.mrc #fld m2 $did(26).text
  writeini script\cfgprt.mrc #fld l2 $did(53).state | writeini script\cfgprt.mrc #fld a3 $did(72).text
  writeini script\cfgprt.mrc #fld m3 $did(27).text | writeini script\cfgprt.mrc #fld l3 $did(54).state
  unset %_cfgprot*
}
on *:dialog:cfgprotect:init:0:{
  set %_cfgprot.tmp 70 | :loop | did -a cfgprotect %_cfgprot.tmp kick | did -a cfgprotect %_cfgprot.tmp ban
  did -a cfgprotect %_cfgprot.tmp kickban | did -a cfgprotect %_cfgprot.tmp tempban | did -a cfgprotect %_cfgprot.tmp msg
  did -a cfgprotect %_cfgprot.tmp onotice | inc %_cfgprot.tmp | if (%_cfgprot.tmp <= 72) { goto loop }
  if ($readini script\cfgprt.mrc #fld a1 == kick) { did -c cfgprotect 70 1 } | if ($readini script\cfgprt.mrc #fld a2 == kick) { did -c cfgprotect 71 1 }
  if ($readini script\cfgprt.mrc #fld a3 == kick) { did -c cfgprotect 72 1 } | if ($readini script\cfgprt.mrc #fld a1 == ban) { did -c cfgprotect 70 2 }
  if ($readini script\cfgprt.mrc #fld a2 == ban) { did -c cfgprotect 71 2 } | if ($readini script\cfgprt.mrc #fld a3 == ban) { did -c cfgprotect 72 2 }
  if ($readini script\cfgprt.mrc #fld a1 == kickban) { did -c cfgprotect 70 3 } | if ($readini script\cfgprt.mrc #fld a2 == kickban) { did -c cfgprotect 71 3 }
  if ($readini script\cfgprt.mrc #fld a3 == kickban) { did -c cfgprotect 72 3 } | if ($readini script\cfgprt.mrc #fld a1 == tempban) { did -c cfgprotect 70 4 }
  if ($readini script\cfgprt.mrc #fld a2 == tempban) { did -c cfgprotect 71 4 } | if ($readini script\cfgprt.mrc #fld a3 == tempban) { did -c cfgprotect 72 4 }
  if ($readini script\cfgprt.mrc #fld a1 == msg) { did -c cfgprotect 70 5 } | if ($readini script\cfgprt.mrc #fld a2 == msg) { did -c cfgprotect 71 5 }
  if ($readini script\cfgprt.mrc #fld a3 == msg) { did -c cfgprotect 72 5 } | if ($readini script\cfgprt.mrc #fld a1 == onotice) { did -c cfgprotect 70 6 }
  if ($readini script\cfgprt.mrc #fld a2 == onotice) { did -c cfgprotect 71 6 } | if ($readini script\cfgprt.mrc #fld a3 == onotice) { did -c cfgprotect 72 6 }
  if (%_cfgprot.nmrshw == 1) { did -c cfgprotect 50 } | if (%_cfgprot[flood].ld == 0) { did -b cfgprotect 22 | did -b cfgprotect 23 | did -b cfgprotect 24 }
  else { did -c cfgprotect 51 } | if (%_cfgprot[flood].l1 == 0) { did -b cfgprotect 70 | did -b cfgprotect 25 | did -b cfgprotect 71 | did -b cfgprotect 26 | did -b cfgprotect 72 | did -b cfgprotect 27 }
  else { did -c cfgprotect 52 } | if (%_cfgprot[flood].l2 == 0) { did -b cfgprotect 71 | did -b cfgprotect 26 | did -b cfgprotect 72 | did -b cfgprotect 27 }
  else { did -c cfgprotect 53 } | if (%_cfgprot[flood].l3 == 0) { did -b cfgprotect 72 | did -b cfgprotect 27 } | else { did -c cfgprotect 54 }
}
on *:dialog:cfgprotect:sclick:91:{ unset %_cfgprot* }
on *:dialog:cfgprotect:sclick:51:{
  if ($did(51).state == 0) { did -b cfgprotect 22 | did -b cfgprotect 23 | did -b cfgprotect 24 }
  else { did -e cfgprotect 22 | did -e cfgprotect 23 | did -e cfgprotect 24 }
}
on *:dialog:cfgprotect:sclick:52:{
  if ($did(52).state == 0) { did -b cfgprotect 70 | did -b cfgprotect 25 }
  else { did -e cfgprotect 70 | did -e cfgprotect 25 }
}
on *:dialog:cfgprotect:sclick:53:{
  if ($did(53).state == 0) { did -b cfgprotect 71 | did -b cfgprotect 26 }
  else { did -e cfgprotect 71 | did -e cfgprotect 26 }
}
on *:dialog:cfgprotect:sclick:54:{
  if ($did(54).state == 0) { did -b cfgprotect 72 | did -b cfgprotect 27 }
  else { did -e cfgprotect 72 | did -e cfgprotect 27 }
}
alias cfgprot {
  set %_cfgprot.msg $readini script\cfgprt.mrc kck msg | set %_cfgprot.nmrshw $readini script\cfgprt.mrc kck nmrshw
  set %_cfgprot.acttm $readini script\cfgprt.mrc act tm | set %_cfgprot[flood].ld $readini script\cfgprt.mrc #fld ld
  set %_cfgprot[flood].chan $readini script\cfgprt.mrc #fld #s | set %_cfgprot[flood].lns $readini script\cfgprt.mrc #fld lns
  set %_cfgprot[flood].tm $readini script\cfgprt.mrc #fld tm | set %_cfgprot[flood].a1 $readini script\cfgprt.mrc #fld a1
  set %_cfgprot[flood].l1 $readini script\cfgprt.mrc #fld l1 | set %_cfgprot[flood].m1 $readini script\cfgprt.mrc #fld m1
  set %_cfgprot[flood].a2 $readini script\cfgprt.mrc #fld a2 | set %_cfgprot[flood].l2 $readini script\cfgprt.mrc #fld l2
  set %_cfgprot[flood].m2 $readini script\cfgprt.mrc #fld m2 | set %_cfgprot[flood].a3 $readini script\cfgprt.mrc #fld a3
  set %_cfgprot[flood].l3 $readini script\cfgprt.mrc #fld l3 | set %_cfgprot[flood].m3 $readini script\cfgprt.mrc #fld m3
  dialog -m cfgprotect cfgprotect
}
; eof
