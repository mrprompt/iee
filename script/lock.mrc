; -- iee script - trava com senha
;
alias lock {
  if (!$dialog(lock)) {
    var %pwd = $dialog(lock,lock)
    if (%pwd == $null) { .writeini -n script\options.ini lock lock 0 }
    if (%pwd !=  $null) { .writeini -n script\options.ini lock lock 1 | .writeini -n script\options.ini lock pass $encode(%pwd) }
  }
}
alias getlock {
  if (!$dialog(getlock)) {
    var %pwd = $dialog(getlock,getlock)
    var %pwd_ = $readini script\options.ini lock pass
    var %pwd.enc = $encode(%pwd)
    if (%pwd.enc  != %pwd_) { echo $colour(kick) -tms $x senha incorreta, acesso negado. saindo... | .timerexit 0 1 .exit y }
  }
}
;
dialog lock {
  title "Trava do Script"
  icon script\iee2.ico
  option dbu
  size -1 -1 150 50
  text "Entre com uma senha para o script ou deixe em branco para desligar a trava", 1, 5 5 100 30
  button "&OK", 2, 110 3 35 12, ok
  button "&Cancel", 3, 110 18 35 12, cancel
  edit "", 4, 5 35 140 11, autohs password result
}
on *:dialog:lock:init:*:did -f lock 4
dialog getlock {
  title "Trava do Script - Pegar Pwd"
  icon script\iee2.ico
  option dbu
  size -1 -1 150 50
  text "O Script está travado, entre com a senha correta para ter acesso", 1, 5 5 100 30
  button "&OK", 2, 110 3 35 12, ok
  button "&Cancel", 3, 110 18 35 12, cancel
  edit "", 4, 5 35 140 11, autohs password result
}
on *:dialog:getlock:init:*:did -f getlock 4
; eof
