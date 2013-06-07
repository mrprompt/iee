. -- iee script - completação de nick
;
on *:input:#: {
  var %estilo = $readini(script\options.ini,nc,estilo)
  var %char = $readini(script\options.ini,nc,char)

  if ($left($1,1) == /) && ($ctrlenter) { say $1- | halt }
  elseif ($left($1,1) == /) && (!$ctrlenter) { return }
  elseif ($right($1,1) isin %char) {
    var %_nickcomp.chr $right($1,1)
    if (%estilo == random) { goto nc.random }
    elseif (%estilo == padrao) { goto nc.padrao }
    else { goto nc.proprio }
  }
  else { say $1- | halt }

  :nc.random
  var %x 
  :i 
  inc %x
  if ($nick($active,%x)) {
    if ($remove($1,%_nickcomp.chr) isin $nick($active,%x)) {
      goto $r(1,18)
      :1 | say  $+ $nick($active,%x) $+  $2- | halt
      :2 | say  $+ $nick($active,%x) $+  $2- | halt
      :3 | say  $+ $nick($active,%x) $+  $2- | halt
      :4 | set %_nick $nick($active,%x) | say  $+ $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $+  $2- | halt
      :5 | set %_nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :6 | set %_nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :7 | set %_nick $nick($active,%x) | say $left(%nick,1) $+ $right($left(%nick,-1),-1) $+ $right(%nick,1) $2- | halt
      :8 | set %_nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :9 | set %_nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :10 | set %_nick $nick($active,%x) | say  $+ $left(%nick,$int($calc($len(%nick) / 3))) $+  $+ $mid(%nick,$calc($int($calc($len(%nick) / 3)) +1),$calc($int($calc($len(%nick) / 3)) + $calc($len(%nick) - $calc($int($calc($len(%nick) / 3)) * 3)))) $+  $+ $right(%nick,$int($calc($len(%nick) / 3))) $+  $2- | halt
      :11 | set %_nick $nick($active,%x) | say  $+ $left(%nick,$int($calc($len(%nick) / 3))) $+  $+ $mid(%nick,$calc($int($calc($len(%nick) / 3)) +1),$calc($int($calc($len(%nick) / 3)) + $calc($len(%nick) - $calc($int($calc($len(%nick) / 3)) * 3)))) $+  $+ $right(%nick,$int($calc($len(%nick) / 3))) $+  $2- | halt
      :12 | say ..( $+ $nick($active,%x) $+ ).. $2- | halt
      :13 | say [ $+ $nick($active,%x) $+ ] $2- | halt
      :14 | say .[ $+ $nick($active,%x) $+ ]. $2- | halt
      :15 | say ( $+ $nick($active,%x) $+ ) $2- | halt
      :16 | say [ $+ $nick($active,%x) $+ ] $2- | halt
      :17 | say :: $+ $nick($active,%x) $+ :: $2- | halt
      :18 | say ( $+ $nick($active,%x) $+ ) $2- | halt
    } 
    goto i 
  }

  :nc.proprio
  var %x 
  :i2
  inc %x
  if ($nick($active,%x)) {
    if ($remove($1,%_nickcomp.chr) isin $nick($active,%x)) {
      say %nc.inicio $+ $nick($active,%x) $+ %nc.fim $2- | halt
    }
    goto i2
  }

  :nc.padrao
  var %x
  :i3 
  inc %x
  if ($nick($active,%x)) {
    if ($remove($1,%_nickcomp.chr) isin $nick($active,%x)) {
      goto $readini(script\options.ini,nc,nc)
      :1 | say  $+ $nick($active,%x) $+  $2- | halt
      :2 | say  $+ $nick($active,%x) $+  $2- | halt
      :3 | say  $+ $nick($active,%x) $+  $2- | halt
      :4 | var %nick $nick($active,%x) | say  $+ $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $+  $2- | halt
      :5 | var %nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :6 | var %nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :7 | var %nick $nick($active,%x) | say $left(%nick,1) $+ $right($left(%nick,-1),-1) $+ $right(%nick,1) $2- | halt
      :8 | var %nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :9 | var %nick $nick($active,%x) | say $left(%nick,1) $+  $+ $right($left(%nick,-1),-1) $+  $+ $right(%nick,1) $2- | halt
      :10 | var %nick $nick($active,%x) | say  $+ $left(%nick,$int($calc($len(%nick) / 3))) $+  $+ $mid(%nick,$calc($int($calc($len(%nick) / 3)) +1),$calc($int($calc($len(%nick) / 3)) + $calc($len(%nick) - $calc($int($calc($len(%nick) / 3)) * 3)))) $+  $+ $right(%nick,$int($calc($len(%nick) / 3))) $+  $2- | halt
      :11 | var %nick $nick($active,%x) | say  $+ $left(%nick,$int($calc($len(%nick) / 3))) $+  $+ $mid(%nick,$calc($int($calc($len(%nick) / 3)) +1),$calc($int($calc($len(%nick) / 3)) + $calc($len(%nick) - $calc($int($calc($len(%nick) / 3)) * 3)))) $+  $+ $right(%nick,$int($calc($len(%nick) / 3))) $+  $2- | halt
      :12 | say ..( $+ $nick($active,%x) $+ ).. $2- | halt
      :13 | say [ $+ $nick($active,%x) $+ ] $2- | halt
      :14 | say .[ $+ $nick($active,%x) $+ ]. $2- | halt
      :15 | say ( $+ $nick($active,%x) $+ ) $2- | halt
      :16 | say [ $+ $nick($active,%x) $+ ] $2- | halt
      :17 | say :: $+ $nick($active,%x) $+ :: $2- | halt
      :18 | say ( $+ $nick($active,%x) $+ ) $2- | halt
    } 
    goto i3
  }
}
;
alias cfgnc dialog -mo dlgnc dlgnc
dialog dlgnc {
  title $strip($gettok($ver,1-3,32)) - Nickcompletion Setup
  size 211 130 396 230
  icon script\iee2.ico
  text "O nick completion faz com que vc precise apenas digitar uma parte do nick para falar com a pessoa. Ex.: MrP: oieeeeee --> MrPrompt: oieeeeee", 1, 7 13 379 29
  radio "", 2, 5 52 15 13, group
  icon 3, 21 49 103 16, $shortfn(script\img\1.jpg)
  radio "", 4, 5 72 15 13
  icon 5, 21 69 103 16, $shortfn(script\img\2.jpg)
  radio "", 6, 5 92 15 13
  icon 7, 21 89 103 16, $shortfn(script\img\3.jpg)
  radio "", 8, 5 112 15 13
  icon 9, 21 109 103 16, $shortfn(script\img\4.jpg)
  radio "", 10, 5 132 15 13
  icon 11, 21 129 103 16, $shortfn(script\img\5.jpg)
  radio "", 12, 5 152 15 13
  icon 13, 21 149 103 16, $shortfn(script\img\6.jpg)
  radio "", 14, 5 172 15 13
  icon 15, 21 169 103 16, $shortfn(script\img\7.jpg)
  radio "", 16, 5 192 15 13
  icon 17, 21 189 103 16, $shortfn(script\img\8.jpg)
  radio "", 18, 5 212 15 13
  icon 19, 21 209 103 16, $shortfn(script\img\9.jpg)
  radio "", 20, 137 52 15 13
  icon 21, 153 49 103 16, $shortfn(script\img\10.jpg)
  radio "", 22, 137 72 15 13
  icon 23, 153 69 103 16, $shortfn(script\img\11.jpg)
  radio "", 24, 137 92 15 13
  icon 25, 153 89 103 16, $shortfn(script\img\12.jpg)
  radio "", 26, 137 112 15 13
  icon 27, 153 109 103 16, $shortfn(script\img\13.jpg)
  radio "", 28, 137 132 15 13
  icon 29, 153 129 103 16, $shortfn(script\img\14.jpg)
  radio "", 30, 137 152 15 13
  icon 31, 153 149 103 16, $shortfn(script\img\15.jpg)
  radio "", 32, 137 172 15 13
  icon 33, 153 169 103 16, $shortfn(script\img\16.jpg)
  radio "", 34, 137 192 15 13
  icon 35, 153 189 103 16, $shortfn(script\img\17.jpg)
  radio "", 36, 137 212 15 13
  icon 37, 153 209 103 16, $shortfn(script\img\18.jpg)
  box "", 38, 261 42 128 120
  radio "Padrão", 49, 271 52 59 13, group
  radio "Aleatório", 39, 271 65 59 13
  radio "Personalizado", 40, 271 78 85 13
  text "Início", 41, 269 97 31 13
  edit "", 42, 303 92 77 19, autohs
  text "Fim", 43, 269 117 31 13
  edit "", 44, 303 112 77 19, autohs
  button "Confirma", 45, 263 169 128 24, ok
  button "Cancela", 46, 263 197 128 24, cancel
  text "char.", 47, 269 141 31 13
  edit "", 48, 303 136 77 19, autohs
}
on *:dialog:dlgnc:init:0:{
  var %nc = $readini(script\options.ini,nc,nc)
  var %char = $readini(script\options.ini,nc,char)
  var %estilo = $readini(script\options.ini,nc,estilo)
  if (%nc == 1) did -c $dname 2
  elseif (%nc == 2) did -c $dname 4
  elseif (%nc == 3) did -c $dname 6
  elseif (%nc == 4) did -c $dname 8
  elseif (%nc == 5) did -c $dname 10
  elseif (%nc == 6) did -c $dname 12
  elseif (%nc == 7) did -c $dname 14
  elseif (%nc == 8) did -c $dname 16
  elseif (%nc == 9) did -c $dname 18
  elseif (%nc == 10) did -c $dname 20
  elseif (%nc == 11) did -c $dname 22
  elseif (%nc == 12) did -c $dname 24
  elseif (%nc == 13) did -c $dname 26
  elseif (%nc == 14) did -c $dname 28
  elseif (%nc == 15) did -c $dname 30
  elseif (%nc == 16) did -c $dname 32
  elseif (%nc == 17) did -c $dname 34
  else did -c $dname 36
  if (%estilo == random)  did -c $dname 39
  if (%estilo == proprio) did -c $dname 40
  if (%estilo == padrao)  did -c $dname 49
  did -ra $dname 42 %nc.inicio
  did -ra $dname 44 %nc.fim
  did -ra $dname 48 %char
}
on *:dialog:dlgnc:sclick:45:{
  if ($did(42).text != $null) .set %nc.inicio $did(42).text
  if ($did(44).text != $null) .set %nc.fim   $did(44).text
  if ($did(48).text != $null) .writeini -n script\options.ini nc char  $did(48).text
  if ($did(39).state) .writeini -n script\options.ini nc estilo random
  elseif ($did(40).state) .writeini -n script\options.ini nc estilo proprio
  else .writeini -n script\options.ini nc estilo padrao
}
on *:dialog:dlgnc:sclick:2:.writeini -n script\options.ini nc nc 1
on *:dialog:dlgnc:sclick:4:.writeini -n script\options.ini nc nc 2
on *:dialog:dlgnc:sclick:6:.writeini -n script\options.ini nc nc 3
on *:dialog:dlgnc:sclick:8:.writeini -n script\options.ini nc nc 4
on *:dialog:dlgnc:sclick:10:.writeini -n script\options.ini nc nc 5
on *:dialog:dlgnc:sclick:12:.writeini -n script\options.ini nc nc 6
on *:dialog:dlgnc:sclick:14:.writeini -n script\options.ini nc nc 7
on *:dialog:dlgnc:sclick:16:.writeini -n script\options.ini nc nc 8
on *:dialog:dlgnc:sclick:18:.writeini -n script\options.ini nc nc 9
on *:dialog:dlgnc:sclick:20:.writeini -n script\options.ini nc nc 10
on *:dialog:dlgnc:sclick:22:.writeini -n script\options.ini nc nc 11
on *:dialog:dlgnc:sclick:24:.writeini -n script\options.ini nc nc 12
on *:dialog:dlgnc:sclick:26:.writeini -n script\options.ini nc nc 13
on *:dialog:dlgnc:sclick:28:.writeini -n script\options.ini nc nc 14
on *:dialog:dlgnc:sclick:30:.writeini -n script\options.ini nc nc 15
on *:dialog:dlgnc:sclick:32:.writeini -n script\options.ini nc nc 16
on *:dialog:dlgnc:sclick:34:.writeini -n script\options.ini nc nc 17
on *:dialog:dlgnc:sclick:36:.writeini -n script\options.ini nc nc 18
;eof
