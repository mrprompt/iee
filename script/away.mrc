; -- iee script - sistema de away
;
dialog away {
  title "Sistema de Away"
  size -1 -1 300 150
  icon script\iee2.ico
  text "&Motivo: ", 6, 14 10 80 20
  combo 1, 10 30 280 120, edit drop
  check "&Pager", 2, 10 60 47 16, group
  check "&Logs", 3, 65 60 43 16
  text "&uin", 7, 200 60 20 16
  edit "", 8, 222 55 68 20
  text "&mail", 9, 90 82 20 16
  edit "", 10, 157 77 134 20, autohs
  check "&Trocar nick", 11, 115 60 75 16
  button "&Away", 4, 10 80 70 17
  button "&Back", 5, 10 100 70 17
  text "&nick de away:", 12, 80 105 75 15, right
  combo 13, 157 99 134 95, edit,drop,autohs
  check "auto-away in:", 14, 10 129 80 15
  edit "", 15, 93 123 100 20
  text "segundos :¬)", 16, 200 129 80 15
  button "", 1000, 0 0 0 0, hide cancel
}
;
on *:dialog:away:init:0: {
  if ($away == $false) { did -b away 5 | did -e away 4 } 
  did -a away 1 Já volto | did -a away 1 I'm busy! | did -a away 1 Ocupado(a)... | did -a away 1 Sleeping... | did -a away 1 Dormindo...zZzZzZzZz | did -a away 1 Bater um rango... | did -a away 1 Tomar um banho ;-) 
  did -a away 13 -Away | did -a away 13 [Away] | did -a away 13 [off] | did -a away 13 [0ff] | did -a away 13 _AuEi | did -a away 13 -f0r4 | did -a away 13 _FoRa | if ($away) { did -b away 4 | did -e away 5  } 
  did -a away 15 $readini script\options.ini away auto-secs
  did -a away 8 $readini script\options.ini away uin
  did -a away 10 $readini script\options.ini away mail
  if ($readini(script\options.ini,away,log)) { did -c away 3 } 
  if ($readini(script\options.ini,away,page)) { did -c away 2 } 
  if ($readini(script\options.ini,away,nick)) { did -c away 11 } 
  if ($readini(script\options.ini,away,autoaway) == yes) .did -c away 14
  if ($away) { did -a away 1 %_reason } 
}
on *:dialog:away:sclick:2:{ .writeini -n script\options.ini away page $did(away,2).state }
on *:dialog:away:sclick:3:{ .writeini -n script\options.ini away log $did(away,3).state }
on *:dialog:away:sclick:4: {
  if ($did(away,1).text != $null) {
    did -b away 4 | did -e away 5 
    if ($did(away,8) != $null) { .writeini script\options.ini  away uin $did(8).text }
    if ($did(away,10) != $null) { .writeini script\options.ini away mail $did(10).text }
    if ($did(away, 13) != $null) .writeini script\options.ini away nickaway $did(13).text
    set %_reason $did(away,1).text 
    set %_time $ctime 
    away $did(away,1).text 
  }
  else {
    did -b away 4 | did -e away 5 
    if ($did(away,8).text != $null) { .writeini script\options.ini  away uin $did(8).text }
    if ($did(away,10).text != $null) { .writeini script\options.ini away mail $did(10).text }
    if ($did(away, 13) != $null) .writeini -n script\options.ini away nickaway $did(13).text
    set %_reason $did(away,1).text 
    set %_time $ctime 
    away sem razão...
  }
}
on *:dialog:away:sclick:5: { if ($away) { did -b away 5  | did -e away 4 | away } }
on *:dialog:away:edit:8:if ($did(away,8) != $null) { .writeini script\options.ini  away uin $did(8).text }
on *:dialog:away:edit:10:if ($did(away,10) != $null) { .writeini script\options.ini away mail $did(10).text }
on *:dialog:away:sclick:11:{
  .writeini -n script\options.ini away nick $did(11).state 
  .writeini -n script\options.ini away nickaway $did(away,13).text 
}
on *:dialog:away:sclick:14:{
  if ($did(away,14).state == 0) { .writeini script\options.ini away autoaway no | .timer666 off }
  if ($did(away,14).state == 1) { .timer666 0 1 autoaway | .writeini script\options.ini away autoaway yes } 
}
on *:dialog:away:edit:15:if ($did(away,15).text != $null) .writeini script\options.ini away auto-secs $did(away,15).text
on *:dialog:away:sclick:100:{
  if ($did(away,8) != $null) { .writeini script\options.ini  away uin $did(8).text }
  if ($did(away,10) != $null) { .writeini script\options.ini away mail $did(10).text }
  .writeini -n script\options.ini away log $did(away,3).state
  .writeini -n script\options.ini away page $did(away,2).state
}
on *:start:{
  if ($exists($mircdirawaylogs.txt)) .remove " $+ $mircdir $+ awaylogs.txt $+ "
  if ($exists($mircdirawaypage.txt)) .remove " $+ $mircdirawaypage.txt $+ "
  if ($readini script\options.ini away autoaway == yes) .timer666 0 1 autoaway
}
on *:text:*:#:{
  if ($away) && ($readini(script\options.ini,away,log)) && ($me isin $strip($1-)) {
    .msg $nick $me está away neste momento: %_reason
    .write $mircdir $+ awaylogs.txt $timestamp - $chan - %b.e $+ $nick $+ %b.d $1- 
  }
}
on *:text:*:=:{
  if ($away) && ($readini(script\options.ini,away,log)) {
    .msg $nick $me está away neste momento: %_reason
    .write $mircdir $+ awaylogs.txt $timestamp - %b.e $+ $nick $+ %b.d $1-
  }
}
raw 305:*:echo $colour(own text) -tma $x Você agora não está mais no modo away... - ( $+ %_reason $+ ) | halt
raw 306:*:echo $colour(own text) -tma $x Você agora está no modo away... - ( $+ %_reason $+ ) | halt
alias autoaway { 
  set %_autoaway $readini script\options.ini away auto-secs
  if ($away) return
  else if ($idle == %_autoaway) && ($server) away Auto-Away 
}
alias viewpageaway if ($?!="Você deseja visualizar os page?") { .window @Away_Page | .loadbuf @Away_Page $mircdir $+ awaypage.txt }
alias viewlogaway if ($?!="Você deseja visualizar os logs?") { .window @Away_Log | .loadbuf @Away_Log $mircdir $+ awaylogs.txt } 
alias away.sistema awaysys
alias awaysys { if ($dialog(away)) return | else dialog -m away away }
alias back if ($away) away | else erro Você não está em modo away.
alias away { 
  if ($away) { 
    away
    if ($chan(0) != 0) ame away off ( $+ %_reason - uin: $readini script\options.ini away uin - mail: $readini script\options.ini away mail - $duration($calc($ctime - %_time)) $+ )
    if ($readini(script\options.ini,away,nick)) { .nick %_away.last.nick | unset %_away.last.nick }
    if ($exists($mircdirawaylogs.txt)) .timer 1 0 viewlogaway
    if ($exists($mircdirawaypage.txt)) .timer 1 0 viewpageaway 
    .timeraway off
    .unset %_reason
    .unset %_time
  }
  else {
    away $1-
    set %_reason $1-
    set %_time $ctime
    if ($chan(0) != 0) ame away on ( $+ %_reason - uin: $readini script\options.ini away uin - mail: $readini script\options.ini away mail - $time $+ )
    if ($readini(script\options.ini,away,nick)) {
      set %_away.last.nick $me
      .nick $me $+ $readini(script\options.ini,away,nickaway)
    }
    if ($exists($mircdirawaylogs.txt)) .remove " $+ $mircdir $+ awaylogs.txt $+ "
    if ($exists($mircdirawaypage.txt)) .remove " $+ $mircdir $+ awaypage.txt $+ " 
    .timeraway 0 900 ame away ( $+ %_reason - uin: $readini script\options.ini away uin - mail: $readini script\options.ini away mail - $time $+ )
  } 
}
ctcp *:page:if ($away) && ($readini(script\options.ini,away,page)) .write $mircdir $+ awaypage.txt $timestamp - < $+ $nick $+ > $2-
;
; EOF
