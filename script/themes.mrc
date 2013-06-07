; - sistema de temas compatível com MTS 1.1 by MrPrompt
alias themes {
  if ($1) { mts $1- | return }
  else { mts }
}
alias mts {
  if (!$1) { if (!$dialog(mts)) dialog -m mts mts | return }
  if ($hget(theme)) hfree theme
  hmake theme 100
  var %i = 1
  var %ii = $calc($lines($1-) + 1)
  while (%i != %ii) {
    var %x = $read -nl $+ %i $1-
    if (%x) && ($left(%x,1) != $chr(59)) {
      hadd theme $gettok(%x,1,32) $gettok(%x,2-,32)
    }
    inc %i 
  }

  ; - borda e linha 
  if ($hget(theme,prefix)) set %prefixo $hget(theme,prefix)
  else set %prefixo $chr(42)

  if ($hget(theme,be)) set %b.e $hget(theme,be)
  else set %b.e $chr(60)

  if ($hget(theme,bd)) set %b.d $hget(theme,bd)
  else set %b.d $chr(62)

  if ($hget(theme,linesep)) set %sep $hget(theme,linesep)
  else set %sep -

  ; - cores RGB
  var %rgb = 0 
  while (%rgb != 16) {
    if ($gettok($hget(theme,RGBcolors),%rgb,32)) {
      color %rgb $rgb( [ $gettok($hget(theme,RGBcolors),$calc(%rgb + 1),32) ] ) 
    }
    else color -r %rgb
    inc %rgb
  }

  ; - Cores
  var %cor = 1
  while (%cor <= 28) { 
    var %local = $gettok(Background.Action text.CTCP text.Highlight text.Info text.Info2 text.Invite text.Join text.Kick text.Mode text.Nick text.Normal text.Notice text.Notify text.Other text.Own text.Part text.Quit text.Topic text.Wallops text.Whois text.Editbox.Editbox text.Listbox.Listbox text.Grayed text.Inactive.Title text,%cor,46)
    colour [ %local ] $gettok($hget(theme,Colors),%cor,44)
    inc %cor
  }

  ; - font dos canais
  if ($chan(0) >= 1) { 
    var %def = 1
    while ($chan(%def)) { 
      if ($hget(theme,fontchan)) font $chan(%def) $gettok($hget(theme,fontchan),2,44) $gettok($hget(theme,fontchan),1,44)
      else font $chan(%def) $gettok($hget(theme,fontdefault),2,44) $gettok($hget(theme,fontdefault),1,44)
      inc %def
    } 
  }
  else {
    if ($hget(theme,fontchan)) .writeini mirc.ini fonts fchannel $hget(theme,fontchan)
    else .writeini mirc.ini fonts fchannel $hget(theme,fontdefault)
  }

  ; - font dos queryes
  if ($query(0) >= 1) {
    var %query = 1
    while ($query(%query)) {
      if ($hget(theme,fontquery)) font $query(%query) $gettok($hget(theme,fontquery),2,44) $gettok($hget(theme,fontquery),1,44)
      else font $query(%query) $gettok($hget(theme,fontdefault),2,44) $gettok($hget(theme,fontdefault),1,44)
      inc %query
    } 
  } 
  else {
    if ($hget(theme,fontquery)) .writeini mirc.ini fonts fquery $hget(theme,fontquery)
    else .writeini mirc.ini fonts fquery $hget(theme,fontdefault)
  }

  ; - font do status
  if ($hget(theme,fontstatus)) { 
    .writeini mirc.ini fonts fstatus $hget(theme,fontstatus)
    font -s $gettok($hget(theme,fontstatus),2,44) $gettok($hget(theme,fontstatus),1,44) 
  }
  else {
    .writeini mirc.ini fonts fstatus $hget(theme,fontdefault)
    font -s $gettok($hget(theme,fontdefault),2,44) $gettok($hget(theme,fontdefault),1,44) 
  }

  ; - font do editor
  if ($hget(theme,fontscript)) .writeini mirc.ini fonts fscripts $hget(theme,fontscript)
  else .writeini mirc.ini fonts fscripts $hget(theme,fontdefault)

  ; - font do DCC
  if ($hget(theme,fontdcc)) .writeini mirc.ini fonts fdccs $hget(theme,fontdcc)
  else .writeini mirc.ini fonts fdccs $hget(theme,fontdcc)

  ; - font padrões dos canais
  if ($hget(theme,fontchan)) .writeini mirc.ini fonts fchannel $hget(theme,fontchan)
  else .writeini mirc.ini fonts fchannel $hget(theme,fontdefault)

  ; - font padrão dos queryes
  if ($hget(theme,fontquery)) .writeini mirc.ini fonts fquery $hget(theme,fontquery)
  else .writeini mirc.ini fonts fquery $hget(theme,fontdefault)

  ; - font do notify
  if ($hget(theme,fontnotify)) .writeini mirc.ini fonts fnotify $hget(theme,fontnotify)
  else .writeini mirc.ini fonts fnotify $hget(theme,fontdefault)

  ; - font dos links
  if ($hget(theme,fontlinks)) .writeini mirc.ini fonts flinks $hget(theme,fontlinks)
  else .writeini mirc.ini fonts flinks $hget(theme,fontdefault)

  ; - font do list
  if ($hget(theme,fontlist)) .writeini mirc.ini fonts flist $hget(theme,fontlist)
  else .writeini mirc.ini fonts flist $hget(theme,fontdefault)

  ; - timestamp
  if ($hget(theme,timestampformat)) .timestamp -fe $hget(theme,timestampformat)
  if ($hget(theme,timestamp)) .timestamp $hget(theme,timestamp)
}

dialog mts {
  title $strip($gettok($ver,1-3,32)) - Temas
  icon script\iee2.ico
  size -1 -1 315 255
  tab "Temas", 1, 3 5 307 223
  tab "Preview", 2
  list 3, 8 32 90 186, size tab 1
  edit "Descrição do Tema", 4, 101 33 204 184, tab 1 read multi return vsbar
  icon 5, 9 31 295 186, $mircexe, tab 2
  button "Carregar", 6, 49 229 84 24
  button "Preview", 7, 137 229 84 24, disabled
  button "Fechar", 8, 227 229 84 24, ok
}
on *:dialog:mts:init:0:{
  did -h $dname 5
  did -r mts 3
  var %total = 1
  var %files = $findfile(themes\,*.mts,0)
  while (%total <= %files) {
    did -a mts 3 $nopath($findfile(themes\,*.mts,%total))
    inc %total
  }
}
on *:dialog:mts:sclick:3:{
  if ($hget(theme)) hfree theme
  hmake theme 100
  var %i = 1
  var %ii = $calc($lines(themes\ $+ $did(3).seltext) + 1)
  while (%i != %ii) {
    var %x = $read -nl $+ %i themes\ $+ $did(3).seltext
    if (%x) && ($left(%x,1) != $chr(59)) {
      hadd theme $gettok(%x,1,32) $gettok(%x,2-,32)
    }
    inc %i 
  }
  did -ra $dname 4 Name: $hget(theme,name) $crlf
  did -a $dname 4 Description: $crlf $+ $hget(theme,description) $crlf
  did -a $dname 4 Author: $hget(theme,author) $crlf
  did -a $dname 4 E-mail: $hget(theme,email) $crlf
  did -a $dname 4 Website: $hget(theme,website) $crlf
  did -a $dname 4 Version: $hget(theme,version) $crlf
  did -a $dname 4 MTS-Version: $hget(theme,mtsversion) $crlf
}
on *:dialog:mts:sclick:2:did -e $dname 7
on *:dialog:mts:sclick:1:did -b $dname 7
on *:dialog:mts:sclick:6:if ($did(3).seltext) { mts themes\ $+ $did(3).seltext }
on *:dialog:mts:sclick:7:{
  if ($did(3).seltext) {
    mts.preview themes\ $+ $did(3).seltext
    did -gv $dname 5 script\mts.preview.bmp
    did -v $dname 5
  } 
}
on *:dialog:mts:sclick:8:if ($isfile(script\mts.preview.bmp)) .remove script\mts.preview.bmp

alias -l mts.preview {
  if (!$window(@mts.preview)) { window -ph +b @mts.preview 100 100 296 187 }
  clear @mts.preview
  drawrect -f @mts.preview  $gettok($hget(theme,Colors),1,44)  $gettok($hget(theme,Colors),1,44) 0 0 296 187
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),16,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 2   $hget(theme,be) $+ MrPrompt $+ $hget(theme,bd) hello all
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),16,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 17  $hget(theme,prefix) $hget(theme,linesep)
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),9,44)  $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 32  $hget(theme,prefix) nick was kicked by MrPrompt
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),2,44)  $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 50  $hget(theme,prefix) * me is away [lunch!!!]
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),8,44)  $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 65  $hget(theme,prefix) MrPrompt is now mIRC
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),16,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 80  $hget(theme,be) $+ mIRC $+ $hget(theme,bd) hmmmmmm
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),12,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 95  $hget(theme,be) $+ baboo $+ $hget(theme,bd) hello MrPrompt !!!
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),19,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 110 $hget(theme,be) $+ #iee $+ $hget(theme,bd) $+ .topic is hello all
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),14,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 125 * nick is online
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),17,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 140 *** baboo parts #iee
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),18,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 155 *** quit nick (no reason)
  drawtext -pb @mts.preview $gettok($hget(theme,Colors),21,44) $gettok($hget(theme,Colors),1,44) $gettok($hget(theme,fontchan),1,44) $gettok($hget(theme,fontchan),2,44) 2 170 $hget(theme,prefix) whois: mIRC: is ~mrprompt@xxxxx.xxx.xx
  drawsave @mts.preview script\mts.preview.bmp
  window -c @preview 
}
;eof
