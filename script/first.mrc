; -- iee script - rotinas iniciais
;
on *:start: { 
  if ($version < 6.0) { echo $colour(info) -tms Somente para mIRC 6.0+ | .timer 0 2 exit y }
  .remote on
  .dlevel 1 
  if ($readini(script\options.ini,lock,lock) == 1) getlock
  splash
  unset %x %y %_*
  .play -cs script\titlebar.txt 50
  if ($numtok(%nicks,44) > 9) set %nicks $deltok(%nicks,1-9,44) $+ ,
  if ($isfile(script\mts.preview.bmp)) .remove script\mts.preview.bmp
  inc %load.times

  var %total = 1
  var %files = $findfile(script\temp\,*.#*,0)
  while (%total <= %files) {
    if ($findfile(script\temp\,*.#*,%total)) { .remove $findfile(script\temp\,*.#*,%total) }
    inc %total
  }
}
alias -l splash {
  ;  window -fph +de @splash 100 100 567 300
  window -pfarodhkBz +bdL @Splash $int($calc(($window(-1).w - 567) / 2)) $int($calc(($window(-1).h - 300) / 2)) 567 300
  window -a @Splash
  var %total = $script(0)
  var %i = 1
  drawrect -fn @splash 1 1 0 0 567 283
  drawpic @splash 0 0 $shortfn(script\img\#iee Script 2.jpg)
  drawtext -n @splash 1 "Verdana" -8 10 260 Loading Script...
  while (%i <= %total) {
    drawrect -fn @splash 12 1 105 261 $int($calc(330 * (%i / %total))) 10
    drawrect -n @splash 1 1 105 261 330 10
    drawpic @splash
    inc %i
  }
}
; eof
