; -- iee script - eventos
;
on *:connect:if ($server $+ : $+ $port !isin %servers) .set %servers %servers $+ $server $+ : $+ $port $+ $chr(44)
on *:dns:{
  if ($naddress == $iaddress) { echo $colour(kick) -tma $x DNS $nick não encontrado | halt }
  elseif ($raddress) { 
    echo $colour(info) -tma $x DNS resolvido $iif($raddress == $iaddress,$naddress,$iaddress) de $raddress
    echo $colour(info) -tma Aperte F10 para copiar. | .set %_F10 clipboard $raddress
    halt
  }
  else { echo $colour(kick) -tma $x Falha resolvendo DNS $iif($iaddress,$iaddress,$naddress) | halt } 
}
on ^*:topic:#:haltdef | .echo $colour(topic text) -tml # $x $nick sets topic to: $1-  | halt
on ^*:usermode:echo $colour(mode text) -tms $x modos mudados para  $+ $colour(notice text) [ $+ $1- $+  $+ $colour(notice text) $+ ] $+  por  $+ $colour(notice text) $nick  | halt
on ^*:wallops:*:haltdef | echo $colour(wallops) -tmlbf # $x wallopsmsg: %b.e $+ $nick $+ %b.d $1- | halt
on *:text:$(* $+  $me $+ *):#:.beep 3 | flash $nick - $chan | echo -tms $x $nick te chamando no $chan
on ^*:join:#:{
  if ($nick == $me) haltdef
  if ($nick isnotify) .cline $colour(notify) # $nick
}
on *:open:?:{
  .echo $colour(own) -tml $nick $x %b.e $+ $nick $+ %b.d $+ -abrindo pvt...
  `foto $nick
}
on *:input:?:{
  if ($left($1,1) == /) && ($ctrlenter) { say $1- | halt }
  elseif ($left($1,1) == /) && (!$ctrlenter) { return }
  else { say $1- | halt }
}
on *:input:=:{
  if ($left($1,1) == /) && ($ctrlenter) { say $1- | halt }
  elseif ($left($1,1) == /) && (!$ctrlenter) { return }
  else { say $1- | halt }
}
on ^*:text:*:#:haltdef | echo -tml $chan %b.e $+  $+ $colour(own) $+ $nick(#,$nick).pnick $+  $+ %b.d $1- | halt
on ^*:text:*:?:haltdef | echo -tml $query($nick) %b.e $+  $+ $colour(own) $+ $nick $+  $+ %b.d $1- | halt
on ^*:text:*:=:haltdef | echo -tml $chat($nick) %b.e $+  $+ $colour(own) $+ $nick $+  $+ %b.d $1- | halt
on me:*:part:#:.echo $colour(own) -tms $x %b.e $+ $chan $+ %b.d parting...
on me:*:join:#:{
  .echo $colour(own) -tml $chan $x %b.e $+ $chan $+ %b.d $+ --joining
  .cline $colour(wallops) # $me
  if (%join.msg != $null) { 
    .msg # %join.msg
    echo -tml # %b.e $+ $me $+ %b.d %join.msg
  }
}
on me:*:nick:if ($newnick !isin %nicks) { .set %nicks $addtok($newnick,%nicks,44) }
on ^*:notice:*:*:{
  haltdef
  var %notices = $readini(script\options.ini,others,notices)
  goto %notices
  :status | echo $colour(notice text) -tms $x Notice: %b.e $+ $nick $+ %b.d $1- | halt
  :ativa | echo $colour(notice text) -tma $x Notice: %b.e $+ $nick $+ %b.d $1- | halt
  :separada {
    if ($window(@Notice)) echo $colour(notice text) -tml @Notice $x - $nick - $1-
    else { .window -e @Notice | .echo $colour(notice text) -tml @Notice $x - $nick - $1- }
    halt
  }
}
on ^*:snotice:*:{
  haltdef
  var %notices = $readini(script\options.ini,others,notices)
  goto %notices
  :status | echo $colour(notice text) -tms $x server-notice: %b.e $+ $nick $+ %b.d $1- | halt
  :ativa | echo $colour(notice text) -tma $x server-notice: %b.e $+ $nick $+ %b.d $1-
  :separada {
    if ($window(@Notice)) { echo $colour(notice text) -tml @SNotice $x - $nick - $1- | halt }
    else { .window -e @Notice | .echo $colour(notice text) -tml @Notice $x - $nick - $1- | halt }
  }
}
on *:NOTICE:*nickserv*identify*:*:{
  if ($readini(script\options.ini,others,autoidentify) == 1) {
    set %me $readini script\pwd.ini nicks $me
    set %pass $decode(%me)
    if ($nick == NickServ) && (%me) .nickserv identify %pass
    unset %pass %me
  }
  else f3
}
CTCP *:PING:*:{
  var %ctcp = $readini(script\options.ini,ctcp,ctcp)
  if (%ctcp == proprio) { ctcpreply $nick PING $readini(script\options.ini,ctcp,ping) | halt }
  else return
}
CTCP *:FINGER:*:{
  var %ctcp = $readini(script\options.ini,ctcp,ctcp)
  if (%ctcp == proprio) { ctcpreply $nick FINGER $readini(script\options.ini,ctcp,finger) | halt } 
  else return
}
CTCP *:USERINFO:*:{
  var %ctcp = $readini(script\options.ini,ctcp,ctcp)
  if (%ctcp == proprio) { ctcpreply $nick USERINFO $readini(script\options.ini,ctcp,userinfo) | halt } 
  else return
}
CTCP *:CLIENTINFO:*:{
  var %ctcp = $readini(script\options.ini,ctcp,ctcp)
  if (%ctcp == proprio) { ctcpreply $nick CLIENTINFO $readini(script\options.ini,ctcp,clientinfo) | halt } 
  else return
}
CTCP *:ECHO:*:{
  var %ctcp = $readini(script\options.ini,ctcp,ctcp)
  if (%ctcp == proprio) { ctcpreply $nick ECHO $readini(script\options.ini,ctcp,echo) | halt } 
  else return
}
CTCP *:VERSION:*:ctcpreply $nick VERSION $ver | halt
;
#autojoin on
on *:connect:if (%canais != $null) .timer 1 $$readini(script\options.ini,others,autojoin.secs) .join %canais
#autojoin end
; eof
