; -- iee script - aliases
;
alias op if ($me isop #) mode # +ooo $$1 $2 $3
alias dop if ($me isop #) mode # -ooo $$1 $2 $3
alias j if ($server) join #$$1 $2-
alias p if ($server) part #$1 $2-
alias n if ($server) names #$$1
alias w if ($server) whois $$1
alias k if ($me isop #) kick # $$1 $2-
alias q if ($server) query $$1
alias send dcc send $1 $2
alias chat dcc chat $1
alias ping if ($server) ctcp $$1 ping
alias b if ($server) ban $1-
alias query .query $$1 $2- | .timer 2 0 `foto $1
alias c clear $1-
alias ca clearall
alias voice if ($me isop #) { mode # +vvv $$1 $2 $3- } | else echo $colour(info text) -a $x Você não é um operador do $chan
alias v if ($me isop #) { mode # +vvv $$1 $2 $3- } | else echo $colour(info text) -a $x Você não é um operador do $chan
alias whoami whois $me
alias sayflood if ($1 == $null) { echo -a Escreve determinadas vezes. Sintaxe: /sayflood <vezes> <texto> | goto fim } | else { %x = 0  | %y = $1 | while (%x < %y) { say $2-  $+ $2- $+   $+ $2- $+   $+ $rand(1,15) $2- $+  $2-  $+ $2- $+   $+ $2- $+   $+ $rand(1,15) $2- $+  $2-  $+ $2- $+   $+ $2- $+   $+ $rand(1,15) $2- $+  $2-  $+ $2- $+   $+ $2- $+   $+ $rand(1,15) $2- $+  $2-  $+ $2- $+   $+ $2- $+   $+ $rand(1,15) $2- $+   | inc %x }  } | :fim  | unset %x
alias sayflood2 if ($server == $null) { echo -a $str($2-,$1) | halt } | elseif ($server) { say $str($2-,$1) | halt }
alias exit if ($1 == $null) { if ($?!="Você tem certeza que deseja sair ?") { .exit y } | else { halt } } |  if ($1 == y) .exit
alias nick if ($1 == $null) nick $entry(Deseja trocar para qual nick?) | else nick $1-
alias anick if ($1 == $null) anick $entry(Trocar nick alternativo para?) | else .anick $$1-
alias part if ($server) .part $1 $gettok($ver,1,32) $2-
alias about config about
alias dlgservers if (!$dialog(servers)) dialog -m servers servers
alias kb if ($me isop #) { mode # +b $address($1,2) | kick # $$1 $2- } | else echo $colour(info text) -tma $x Você não é operador do $chan
alias quit { 
  if ($1 == $null) .quit $ver
  elseif ($1 == random) .quit $gettok($ver,1,32) $+ : $read script\quits.txt
  else quit $gettok($ver,1,32) $+ : $1- 
}
alias topic {
  if ($1 == $null) {
    if (# isin $active) { .set %_chan $chan  | dialog -m topic topic }
    else { topic $entry(Mudar tópico de) $entry(Conteúdo do tópico) }
  }
  elseif ($active isin $1) && ($2 == $null) { .set %chan $1 | dialog -m topic topic }
  elseif ($active isin $1) && ($2 != $null) { topic # $2- }
  else { topic # $1- }
}
alias tt {
  if ($server) goto connected 
  else goto notconnected 
  :connected 
  if ($away) { titlebar - $me - $server $+ : $+ $port [[ $+ $network $+ ]] - Away: %_reason - Idle: $duration($idle) | return } 
  elseif ($active ischan) { var %_act $active | var %_act.d @: $+ $nick(%_act,0,o) +v: $+ $vnick(%_act,0) n: $+ $calc($nick(%_act,0) - ($opnick(%_act,0) + $vnick(%_act,0))) t: $+ $nick(%_act,0) | titlebar - $me - $server $+ : $+ $port [[ $+ $network $+ ]] - $active $+ : [[ $+ %_act.d $+ ]] - Idle: $duration($idle) | return } 
  else { titlebar - $me - $server $+ : $+ $port [ $network ] - Idle: $duration($idle) | return } 
  :notconnected 
  titlebar .:: $+ $strip($gettok($ver,1-3,32)) :: coded by $author  - $me - offline
}
alias kick {
  ;==============
  ; opções:
  ; - informar somente o nick
  ; - kck, nmrshw
  ;   |_ 0 = não mostra o número do kick
  ;   |_ 1 = mostra o número do kick
  if ($1 == $null) { goto end }
  if ($left($1,1) != $chr(35)) {
    set %_kck.chn #
    set %_kck.nck $1
    set %_kck.msg $2-
  }
  else {
    set %_kck.chn $1
    set %_kck.nck $2
    set %_kck.msg $3-
  }
  if (%_kck.msg == $null) {
    if ($readini(script\cfgprt.mrc,kck,msg) == rnd) {
      set %_kck.msg $read $mircdirscript\kicks.txt
    }
    else {
      set %_kck.msg $readini(script\cfgprt.mrc,kck,msg)
    }
  }
  set %_kck.nmr $readini(script\cfgprt.mrc,kck,nmr)
  inc %_kck.nmr
  writeini script\cfgprt.mrc kck nmr %_kck.nmr
  if ($readini(script\cfgprt.mrc,kck,nmrshw) == 1) {
    set %_kck.msg %_kck.msg %b.e $+  $+ $chr(35) $+  $+ %_kck.nmr $+ %b.d
  }
  kick %_kck.chn %_kck.nck %_kck.msg
  :end
}
alias say { 
  if (%saycolor) { 
    .msg $active  $+ %saycolor $+ $1- $+ 
    .echo $colour(own text) -tma %b.e $+ $me $+ %b.d  $+ %saycolor $+ $1- $+  
  }
  else { 
    .msg $active $1-
    .echo $colour(own text) -tma %b.e $+ $me $+ %b.d $1-
  }
}
alias amsg {
  var %canal 1
  var %total $chan(0)
  while (%canal <= %total) {
    if (%saycolor) {
      .msg $chan(%canal)  $+ %saycolor $+ $1- $+ 
      echo $colour(own text) -tml $chan(%canal) %b.e $+ $me $+ %b.d  $+ %saycolor $+ $1- $+ 
    }
    else {
      .msg $chan(%canal) $1-
      echo $colour(own text) -tml $chan(%canal) %b.e $+ $me $+ %b.d $1-
    }
    inc %canal
  }
}
alias myver {
  if (# isin $active) { say is using #IEE Script $ver² by $author | say #IEE Script home-page: $site }
  elseif (($server == $null) || ($active == Status Window)) { echo $colour(own) -tma $x Você está usando o #IEE Script $ver² by $author | echo $colour(own) -tma $x #IEE Script home-page: $site }
  else { say is using #IEE Script $ver² by $author | say #IEE Script home-page: $site }
}
alias `foto {
  if ($readini(script\options.ini,others,foto-pvt) == 1) {
    var %dir  = $readini(script\options.ini,others,fotos-dir)
    var %foto = $lower($query($1-) $+ .jpg)
    if ($isfile(%dir $+ %foto)) .background -p $lower($query($1-)) %dir $+ %foto
  }
}
; eof
