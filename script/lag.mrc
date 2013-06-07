; -- checador de lag
alias lag if (!$dialog(dlglag)) dialog -m dlglag dlglag
alias -l lag1 {
  if ($server) { 
    set %_lagtempo $ctime
    set %_lagtempo2 $ticks
    .ctcp $me LAG $ctime
  }
}
dialog dlglag {
  title $strip($gettok($ver,1-3,32)) - Lag meter
  size -1 -1 179 53
  icon script\iee2.ico
  text "Checar a cada:", 1, 5 12 79 13
  edit %lag.check, 2, 82 7 61 20, autohs
  text "segs.", 3, 145 12 31 13
  check "&Ativar", 4, 5 34 51 13
  button "OK", 5, 66 31 75 18, ok
}
on *:dialog:dlglag:init:0:{
  if ($timer(lag)) { did -c $dname 4 | did -e $dname 2 }
  else { did -u $dname 4 | did -b $dname 2 }
}
on *:dialog:dlglag:edit:2:if ($did(2).text != $null) .set %lag.check $did(2).text
on *:dialog:dlglag:sclick:4:{
  if ($did(4).state) { did -e $dname 2 }
  else { did -b $dname 2 }
}
on *:dialog:dlglag:sclick:5:{
  if ($did(4).state) { .timerlag 0 %lag.check .lag1 | did -e $dname 2 | .window -lkvz +l @lag %lag.x %lag.y 150 40 }
  else { if ($timer(lag)) { .timerlag off | .unset %lag.check | did -b $dname 2 | if ($window(@lag)) window -c @lag } }
}
CTCP ^*:LAG:*:{
  haltdef
  var %_lagreal $round($calc($ctime - %_lagtempo) $+ . $+ $left($calc($ticks - %_lagtempo2),2),2)
  if (!$window(@lag)) { .window -lkvz +l @lag 200 100 150 40 }
  clear @lag | aline @lag $x Lag: %_lagreal segundos
}
on *:start:if (%lag.check != $null) { .timerlag 0 %lag.check .lag1 }
on *:close:@lag:{
  if ($timerloag) { .timerlag off }
  set %lag.x $window(@lag).x
  set %lag.y $window(@lag).y
}
;
;eof
