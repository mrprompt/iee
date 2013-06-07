; -- iee script - menus
;
menu status,channel,menubar {
  -
  &Nick
  .$nicks(1):nick $nicks(1)
  .$nicks(2):nick $nicks(2)
  .$nicks(3):nick $nicks(3)
  .$nicks(4):nick $nicks(4)
  .$nicks(5):nick $nicks(5)
  .$nicks(6):nick $nicks(6)
  .$nicks(7):nick $nicks(7)
  .$nicks(8):nick $nicks(8)
  .$nicks(9):nick $nicks(9)
  .-
  .$iif(%nicks != $null,outro):nick
  .-
  .deletar:.set %nicks $remtok(%nicks,$$?="Remover qual nick?",44) $+ $chr(44)
  .$iif(%nicks != $null,limpar):.unset %nicks | .set %nicks $me $+ $chr(44)
  &Auto-join
  .Abrir:.autojoin
  .-
  .$canais(1):j $canais(1)
  .$canais(2):j $canais(2)
  .$canais(3):j $canais(3)
  .$canais(4):j $canais(4)
  .$canais(5):j $canais(5)
  .$canais(6):j $canais(6)
  .$canais(7):j $canais(7)
  .$canais(8):j $canais(8)
  .$canais(9):j $canais(9)
  .-
  . $iif(%canais != $null,Entrar em todos):.join %canais
  .-
  . $iif(# isin $active && $active !isin %canais,Adicionar #):.set %canais %canais $+ $chan $+ ,
  . $iif(# isin $active && $active isin %canais,Deletar #):..set %canais $remtok(%canais,$chan,44) $+ ,
  .-
  . $iif(%canais != $null,Limpar):.unset %canais
  -
  &MP3
  .&Tocar:mp3
  .&Player:mp3player
  .&Aleatória:f5
  .-
  .$iif($inmp3,&Parar):splay -p stop
  .-
  .$iif(%mp3.publish == 1, $chr(248) &Publicar):set %mp3.publish 0 | echo -tma $x Publicação de suas MP3 desligada...
  .$iif(%mp3.publish != 1,&Publicar):set %mp3.publish 1 | echo -tma $x Publicação de suas MP3 ligada...
  .-
  .&Cfg mp3 dir.:setdir
  $iif($server,Away)
  .$iif($away == $false,$chr(32) $+ $chr(32) $+ $chr(32) $+ Away...):away $entry(Motivo do away:)
  .$iif($away == $false,ø &Voltar):echo $colour(own) -a $x Você não está away...
  .$iif($away == $true,ø Away):echo $colour(own) -a $x Você já está away...
  .$iif($away == $true,$chr(32) $+ $chr(32) $+ $chr(32) $+ &Voltar):back
  .-
  .Sistema:awaysys
  &janela
  .fonte:font
  .-
  .log
  ..ligar:log on
  ..desligar:log off
  .limpar
  ..ativa:clear $active
  ..todas:clearall
  .&Fechar
  ..Inativas: close -i
  ..-
  ..Canais:partall
  ..PVTs: close -m
  ..FServes: close -f
  ..-
  ..DCC chats: close -c
  ..DCC gets: close -g
  ..DCC sends: close -s
  ..-
  ..Fechar todas: close -icfgms
  -
  $iif($server,&Quit)
  .iee:quit
  .quit?:quit $entry(Mensagem de quit (dica: digite random se desejar uma mensagem aleatória))
  .random:quit random
}
; eof
