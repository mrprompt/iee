; -- iee script - mp3 player
;
dialog yn {
  title "#IEE Script MP3 Player: Randômica, confirmar..."
  size -1 -1 220 30
  icon script\iee2.ico
  option type dbu
  text $nopath(%_mp3), 1, 1 1 219 15, center
  button "&Tocar", 98, 5 17 50 12, ok result
  button "&Outra", 99, 63 17 50 12
  button "&Cancelar", 100, 120 17 50 12, cancel
  check "C&ontínuo", 101, 173 21 45 8
}
on *:dialog:yn:init:*:if (%_mp3.cont == 1) .did -c yn 101
on *:dialog:yn:sclick:99:.set %_mp3 $findfile(%mp3.dir,*.mp?,$rand(1,$findfile(%mp3.dir,*.mp?,0))) | did -ra yn 1 $nopath(%_mp3)
on *:dialog:yn:sclick:101:{ if ($did(yn,101).state == 1) .set %_mp3.cont 1 | if ($did(yn,101).state == 0) .set %_mp3.cont 0 }
alias mp3random { .set %_mp3 $findfile(%mp3.dir,*.mp3,$rand(1,$findfile(%mp3.dir,*.mp3,0))) | var %yn = $dialog(yn,yn,-4) | if (tocar isin %yn) { mp3 %_mp3 } }
alias mp3player if ($dialog(mp3player)) return | else dialog -md mp3player mp3player
alias mp3 { if ($1 == $null) { set %_mp3 $$sfile(%mp3.dir $+ *.mp?,Escolha a mp3,Play) | splay -p " $+ %_mp3 $+ " | .timer 1  0 publish | return } | elseif ($1 == player) { mp3player | return } | elseif ($1 == stop) { splay -p stop | return } | else { set %_mp3 $1- | splay -p " $+ $1- $+ " | .timer 1 0 publish | return } }
dialog mp3player {
  title "#IEE Script MP3 Player"
  size %mp3player.x %mp3player.y 270 93
  icon script\iee2.ico
  box "",  1, 0 0 270 92
  edit "", 2, 2 6 70 18, center, read
  edit "", 3, 72 6 195 18, center, read
  edit "", 4, 2 23 70 18, center, read
  edit "", 5, 72 23 30 18, right, read
  text "Kbps", 6, 102 28 30 15, left
  edit "", 7, 130 23 30 18, right, read
  text "KHz", 8, 160 28 30 18, left
  text "mono", 9, 205 28 30 15, disable
  text "stereo", 10, 235 28 30 15, disable
  button "-", 11, 74 45 20 10
  text "volume", 12, 99 43 40 15, left
  button "+", 13, 138 45 20 10
  button "eq", 14, 205 45 28 15
  check "pl", 15, 237 45 28 15, push
  box "", 16, 2 55 265 15
  button "|<", 17, 4 73 20 15
  button ">", 18, 25 73 20 15
  check "| |", 19, 46 73 20 15, push
  button "[]", 20, 67 73 20 15
  button ">|", 21, 88 73 20 15
  button "&^", 22, 113 73 20 15
  button "random", 23, 141 73 40 15
  check "cont.", 24, 183 73 40 15, push
  button "about", 25, 225 73 40 15
  check "publicar", 26, 4 45 67 15, push
  button "", 28, 0 0 0 0, cancel
}
;
on *:dialog:mp3player:init:0: { 
  if (%playlist == 1) { dialog - $+ md playlist playlist | did -c mp3player 15 }
  if (%mp3.publish == 1) { did -c mp3player 26 }
  if (%_mp3.cont == 1) { did -c mp3player 24 }
  if ($inmp3) {
    did -a mp3player 2 $duration($calc($mp3(%_mp3).length / 1000))
    did -a mp3player 3 $mp3(%_mp3).artist - $mp3(%_mp3).album - $mp3(%_mp3).title
    did -a mp3player 4 $mp3(%_mp3).genre
    did -a mp3player 5 $mp3(%_mp3).bitrate
    did -a mp3player 7 $calc($mp3(%_mp3).sample / 1000)
    if (%mp3.publish) did -c mp3player 26
    if ($mp3(%_mp3).mode == Joint Stereo) { did -e mp3player 10 | did -b mp3player 9 }
    if ($mp3(%_mp3).mode != Joint Stereo) { did -e mp3player 9  | did -b mp3player 10 }
  }
}
on *:dialog:mp3player:sclick:11:vol -p $calc($vol(mp3) - 5000)
on *:dialog:mp3player:sclick:13:vol -p $calc($vol(mp3) + 5000)
on *:dialog:mp3player:sclick:14:if ( $exists($windir $+ \SNDVOL32.EXE) ) { .run $windir $+ \SNDVOL32.EXE }
on *:dialog:mp3player:sclick:15: { 
  if ($did(15).state == 1) { dialog -md playlist playlist | set %playlist $did(mp3player,15).state } 
  if ($did(15).state == 0) { if ($dialog(playlist)) dialog -c playlist playlist | set %playlist $did(mp3player,15).state }
} 
on *:dialog:mp3player:sclick:17: {
  if ($dialog(playlist)) {
    did -c playlist 1 $calc($did(playlist,1).sel - 1)
    set %_mp3 " $+ %mp3.dir $+ $did(playlist,1).seltext $+ .mp3"
    if ($inmp3) { .mp3player.play }
  }
  else {
    set %_mp3 " $+ $findfile(%mp3.dir,*.mp3,$rand(1,$findfile(%mp3.dir,*.mp3,0))) $+ "
    .mp3player.play
  }
}
on *:dialog:mp3player:sclick:18:if (%_mp3 != $null) { .mp3player.play } | else return
on *:dialog:mp3player:sclick:19:if ($did(19).state == 1) { splay -p pause  } | if ($did(19).state == 0) { splay -p resume }
on *:dialog:mp3player:sclick:20:.splay -p stop | .did -r mp3player 2,3,4,5,7,10,9
on *:dialog:mp3player:sclick:21: {
  if ($dialog(playlist)) {
    did -c playlist 1 $calc($did(playlist,1).sel + 1)
    set %_mp3 " $+ %mp3.dir $+ $did(playlist,1).seltext $+ .mp3"
    if ($inmp3) { mp3player.play }
  }
  else {
    set %_mp3 " $+ $findfile(%mp3.dir,*.mp3,$rand(1,$findfile(%mp3.dir,*.mp3,0))) $+ "
    .mp3player.play
  }
}
on *:dialog:mp3player:sclick:22:.set %_mp3 $sfile(%mp3.dir,Selecione a mp3:,Play) | .mp3player.play
on *:dialog:mp3player:sclick:23: {
  if ($dialog(playlist)) {
    did -c playlist 1 $r(1,$did(playlist,1).lines) 
    set %_mp3 " $+ %mp3.dir $+ $did(playlist,1).seltext $+ .mp3"
    .mp3player.play
  }
  else {
    set %_mp3 " $+ $findfile(%mp3.dir,*.mp3,$rand(1,$findfile(%mp3.dir,*.mp3,0))) $+ "
    .mp3player.play
  }
}
on *:dialog:mp3player:sclick:24: {
  if ($did(24).state == 1) { .set %_mp3.cont 1 | if ($dialog(mp3player)) { did -c mp3player 24 } }
  if ($did(24).state == 0) { .set %_mp3.cont 0 | if ($dialog(mp3player)) { did -u mp3player 24 } }
}
on *:dialog:mp3player:sclick:25:.dialog -m mp3player.about mp3player.about
on *:dialog:mp3player:sclick:26:if ($did(26).state == 1) { .set %mp3.publish $did(26).state } | if ($did(26).state == 0) { .set %mp3.publish $did(26).state }
on *:dialog:mp3player:sclick:28: { if ($dialog(playlist)) dialog -c playlist playlist | .set %mp3player.x $dialog(mp3player).x | .set %mp3player.y $dialog(mp3player).y }
;
alias -l mp3player.play {
  if (%_mp3) {
    .did -r mp3player 2,3,4,5,7,10,9
    splay -p %_mp3
    did -a mp3player 2 $duration($calc($mp3(%_mp3).length / 1000))
    did -a mp3player 3 $mp3(%_mp3).artist - $mp3(%_mp3).title
    did -a mp3player 4 $mp3(%_mp3).genre
    did -a mp3player 5 $mp3(%_mp3).bitrate
    did -a mp3player 7 $calc($mp3(%_mp3).sample / 1000)
    if (stereo isin $mp3(%_mp3).mode) || (dual isin $mp3(%mp3).mode) { did -e mp3player 10 | did -b mp3player 9 | set %_mp3.mode stereo }
    if (mono isin $mp3(%_mp3).mode) || (single isin $mp3(%_mp3).mode) { did -e mp3player 9  | did -b mp3player 10 | set %_mp3.mode Mono }
    .timer 1 0 publish
  }
}
;
dialog playlist {
  title "#IEE Script MP3 Player: Playlist"  
  size %mp3player.x $calc(%mp3player.y + 118) 270 340
  icon script\iee2.ico
  list 1, 0 0 269 320, sort
  button "Atualizar", 2, 2 305 55 15
  button "Criar Lista", 3, 2 324 55 15
  radio ".txt", 4, 70 305 40 15, group
  radio ".html", 5, 70 324 40 15
  button "+mp3", 6, 120 305 50 15
  button "-mp3", 7, 120 324 50 15
  button "mp3 dir", 8, 173 305 50 15
  button "about", 9, 173 324 50 15
  icon 10, 230 305 32 32, script\iee2.ico
  button "&ok", 999, 0 0 0 0, hide
  button "cancel", 998, 0 0 0 0, hide cancel
}
on *:dialog:playlist:init:0:{
  var %myplaylist = %mp3.dir $+ $me $+ _playlist.txt
  if ($exists(%myplaylist)) { loadbuf -o playlist 1 %myplaylist | return }
  else { 
    var %mp3.total = $findfile(%mp3.dir, *.mp3, 0, did -a playlist 1 $nopath($remove($1-,.mp3)))
    did -c playlist 4 
  }
}
on *:dialog:playlist:sclick:1:set %_mp3 " $+ $findfile(%mp3.dir,$did(playlist,1).seltext $+ .mp3, 1) $+ "
on *:dialog:playlist:dclick:1:set %_mp3 " $+ $findfile(%mp3.dir,$did(playlist,1).seltext $+ .mp3, 1) $+ " | .mp3player.play
on *:dialog:playlist:sclick:2:did -r playlist 1 | var %mp3.total = $findfile(%mp3.dir, *.mp3, 0, did -a playlist 1 $nopath($remove($1-,.mp3)))
on *:dialog:playlist:sclick:3:if ($did(playlist, 5).state ) { .mp3player.list html }  |  if ($did(playlist, 4).state ) { .mp3player.list txt }
on *:dialog:playlist:sclick:6:.timer 1 0 .playlist.add
on *:dialog:playlist:sclick:7: { if ($did(1).sel != $null) { .did -d playlist 1 $did(playlist,1).sel } }
on *:dialog:playlist:sclick:8:.timer 1 0 .setdir
on *:dialog:playlist:sclick:9:if ($dialog(mp3player.about) != $true) .dialog -m mp3player.about mp3player.about
on *:dialog:playlist:sclick:998:{ if ($dialog(mp3player)) .did -u mp3player 15 }
on *:dialog:playlist:sclick:999:set %_mp3 " $+ %mp3.dir $+ $did(playlist,1).seltext $+ .mp3" | .mp3player.play
alias setdir { 
  if ($1) { set %mp3.dir $1- }
  else { set %mp3.dir $$sdir(c:\,Selecione o diretório de suas mp3:) }
  if ($dialog(playlist)) { 
    did -r playlist 1
    var %mp3.total = $findfile(%mp3.dir, *.mp3, 0, did -a playlist 1 $nopath($remove($1-,.mp3)))
    did -c playlist 4  
  } 
}
alias publish { 
  if (%mp3.publish == 1) { 
    if ($chan(0) != 0) {
      if ($mp3(%_mp3).artist != $null) && ($mp3(%_mp3).title != $null) ame ø plays  $mp3(%_mp3).artist ( $+ $mp3(%_mp3).album $+ ) - $mp3(%_mp3).title  $duration($calc($mp3(%_mp3).length / 1000)) ( $+ $mp3(%_mp3).bitrate $+ kbps $calc($mp3(%_mp3).sample / 1000) $+ kHz $mp3(%_mp3).mode $+ )
      else ame ø plays  $nopath(%_mp3)   $duration($calc($mp3(%_mp3).length / 1000)) ( $+ $mp3(%_mp3).bitrate $+ kbps $calc($mp3(%_mp3).sample / 1000) $+ kHz $mp3(%_mp3).mode $+ )
    }
  }
  if ($chan(0) == 0) { 
    if ($mp3(%_mp3).artist != $null) && ($mp3(%_mp3).title != $null) echo $colour(action text) -tma ø playing  $mp3(%_mp3).artist ( $+ $mp3(%_mp3).album $+ ) - $mp3(%_mp3).title  $duration($calc($mp3(%_mp3).length / 1000)) ( $+ $mp3(%_mp3).bitrate $+ kbps $calc($mp3(%_mp3).sample / 1000) $+ kHz $mp3(%_mp3).mode $+ ) 
    else echo $colour(action text) -tma ø playing  $nopath(%_mp3)   $duration($calc($mp3(%_mp3).length / 1000)) ( $+ $mp3(%_mp3).bitrate $+ kbps $calc($mp3(%_mp3).sample / 1000) $+ kHz $mp3(%_mp3).mode $+ )
  } 
}
alias -l playlist.add set %_mp3sel $$file="Adicionar qual arquivo a playlist?" %mp3.dir*.mp3 | did -a playlist 1 %_mp3sel | unset %_mp3sel
alias -l mp3player.list {
  var %mp3list $me $+ -MP3
  if ($1 == html) {
    var %list $mircdir $+ %mp3list $+ .html
    if ($exists(%list)) { .remove " $+ %list $+ " }
    write %mp3list $+ .html <html><head>
    write %mp3list $+ .html <style TYPE="text/css">
    write %mp3list $+ .html   .para1 $chr(123) margin-top: -35px; margin-left: 50px;  font-family: "Arial, Helvetica"; font-size: 25px; line-height: 28px; text-align: left; color: #E1E1E1; $chr(125)
    write %mp3list $+ .html   .para2 $chr(123) margin-top: 5px; margin-left: 15px; font-family: "Arial Black, Arial, Helvetica"; font-size: 40px; line-height: 35px; text-align: left; color: #004080; $chr(125)
    write %mp3list $+ .html </style>
    write %mp3list $+ .html <title>:: Lista de mp3 de %mp3.dir ::</title>
    write %mp3list $+ .html </head>
    write %mp3list $+ .html <body BGCOLOR="#000040" topmargin="0" leftmargin="0" link="#409FFF" vlink="#409FFF" alink="#004080" text="#FFFFFF">
    write %mp3list $+ .html <div CLASS="para2" align="center"><p>IEE2</p></div>
    write %mp3list $+ .html <div CLASS="para1" align="center"><p>MPEG Player</p></div>
    write %mp3list $+ .html Diretório: %mp3.dir <br>
    write %mp3list $+ .html <pre>
    write %mp3list $+ .html $findfile(%mp3.dir, *.mp3, 0, 1, write %mp3list $+ .html $nopath($remove($1-,.mp3)))
    write %mp3list $+ .html </pre>
    write %mp3list $+ .html <hr size=2 width=99%>
    write %mp3list $+ .html <div align="right">MPEG Three Player by MrPrompt - Copyright &copy; 2000, Todos os direitos reservados.<BR></div>
    write %mp3list $+ .html </body>
    write %mp3list $+ .html </html>
    run $readini $mircini files browser "file:// $+ $mircdir $+ %mp3list $+ .html $+ "
    halt
  }
  if ($1 == txt) {
    var %list $mircdir $+ %mp3list $+ .txt
    if ($exists(%list)) { .remove " $+ %list $+ " }
    write %mp3list $+ .txt :: Lista de mp3 de %mp3.dir ::
    write %mp3list $+ .txt --------------------------------------------------
    write %mp3list $+ .txt $findfile(%mp3.dir, *.mp3, 0, 1, write %mp3list $+ .txt $nopath($remove($1-,.mp3)))
    write %mp3list $+ .txt --------------------------------------------------
    write %mp3list $+ .txt MPEG Three Player by MrPrompt - Copyright &copy; 2000, Todos os direitos reservados.
    run notepad " $+ $mircdir $+ %mp3list $+ .txt $+ "
    halt
  }
}
on *:dialog:playlist:sclick:10:.timer 1 0 .lp
alias -l lp did -r playlist 1 | .loadbuf -o playlist 1 " $+ $$sfile(%mp3.dir,Selecione a playlst,Load) $+ "
;
dialog mp3player.about {
  title "#IEE Script MP3 Player"
  size -1 -1 220 120
  icon script\iee2.ico
  box "", 1, 0 0 160 115
  text "MP3 Player para #IEE Script", 2, 2 10 150 20, center
  text "coded by MrPrompt", 3, 2 25 150 20, center
  link "www.mrprompt.cjb.net", 4, 25 45 105 15, center
  link "MrPrompt@bol.com.br", 8, 25 65 130 20, center
  button "&close", 9, 40 85 80 20, ok
  icon 10, 165 1 32 32, script\iee2.ico
}
on *:dialog:mp3player.about:sclick:4:.run $did(mp3player.about,4).text
on *:dialog:mp3player.about:sclick:8:.run mailto:MrPrompt@bol.com.br
;
on *:start:{
  if (%mp3player.x == $null) .set %mp3player.x 1
  if (%mp3player.y == $null) .set %mp3player.y 1
  if (%mp3.dir == $null) setdir
}
;
on *:mp3end:{
  if (%_mp3.cont == 1) {
    .set %_mp3 $findfile(%mp3.dir,*.mp3,$rand(1,$findfile(%mp3.dir,*.mp3,0)))
    .splay -p %_mp3
    if ($dialog(mp3player)) {
      did -r mp3player 2,3,4,5,7,10,9
      did -a mp3player 2 $duration($calc($mp3(%_mp3).length / 1000))
      did -a mp3player 3 $mp3(%_mp3).artist - $mp3(%_mp3).album - $mp3(%_mp3).title
      did -a mp3player 4 $mp3(%_mp3).genre
      did -a mp3player 5 $mp3(%_mp3).bitrate
      did -a mp3player 7 $calc($mp3(%_mp3).sample / 1000)
      if (%mp3.publish) did -c mp3player 26
      if ($mp3(%_mp3).mode == Joint Stereo) { did -e mp3player 10 | did -b mp3player 9 }
      if ($mp3(%_mp3).mode != Joint Stereo) { did -e mp3player 9  | did -b mp3player 10 }
    }
    publish
  }
}
;
; eof
