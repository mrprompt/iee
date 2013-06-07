; -- iee script - services
; 
alias ni .nickserv info $1
alias ci .chanserv info #$1
alias opme .msg chanserv op # $me
menu menubar,status,channel {
  $iif($server,Services)
  .&nickserv
  ..identify:.nickserv identify $$?*="Senha do nick"
  ..register:.nickserv register $$?*="Senha para o nick:" $$entry(E-mail para contato:)
  ..ghost:.nickserv ghost $$entry(Nick:) $$?*="Senha do nick:"
  ..recover:.nickserv recover $$entry(Nick:) $$?*="Senha:"
  ..release:.nickserv release $$entry(Nick:) $$?*="Senha:"
  ..info:.nickserv info $$entry(Nick:)
  ..-
  ..drop:.nickserv drop
  ..-
  ..info:.nickserv info $$entry(Nick:)
  ..list:.nickserv list $$entry(Mask:)
  ..status:.nickserv status $$entry(Nick:)
  ..-
  ..access
  ...add:.nickserv add $$entry(Nick:)
  ...del:.nickserv access del $$entry(Nick:)
  ...list:.nickserv access list
  ..set
  ...password:.nickserv set password $$?*="Mudar senha para:"
  ...-
  ...email:.nickserv set email $$entry(E-mail:)
  ...url:.nickserv set url $$entry(URL:)
  ...uin:.nickserv set uin $$entry(UIN (número no ICQ))
  ...linguagem:.nickserv set language $$entry(Linguagem)
  ...-
  ...kill
  ....on:.nickserv set kill on
  ....off:.nickserv set kill off
  ....quick:.nickserv set kill quick
  ...private
  ....on:.nickserv set private on
  ....off:.nickserv set private off
  ...secure
  ....on:.nickserv set secure on
  ....off:.nickserv set secure off
  ...hide
  ....email
  .....on:.nickserv set hide email on
  .....off:.nickserv set hide email off
  ....url
  .....on:.nickserv set hide url on
  .....off:.nickserv set hide url off
  ....quit
  .....on:.nickserv set hide quit on
  .....off:.nickserv set hide quit off
  ....usermask
  .....on:.nickserv set hide usermask on
  .....off:.nickserv set hide usermask off
  .&chanserv
  ..register:{
    if (# isin $active) { .chanserv register # $$?*="Senha:" $$entry(Descrição) }
    else { .chanserv register $$entry(Canal (com #)) $$?*="Senha:" $$entry(Descrição) }
  }
  ..identify:{
    if (# isin $active) { .chanserv identify # $$?*="Senha:" }
    else { .chanserv identify $$entry(Canal (com #)) $$?*="Senha:" }
  }
  ..info:{
    if (# isin $active) { .chanserv info # }
    else { .chanserv info $$entry(Pegar info de que canal?) }
  }
  ..-
  ..set
  ...founder:{
    if (# isin $active) { .chanserv set # founder $$entry(Nick do novo founder) }
    else { .chanserv set $$entry(Canal (com #)) founder $$entry(Nick do novo founder) }
  }
  ...sucessor:{
    if (# isin $active) { .chanserv set # sucessor $$entry(Nick:) }
    else { .chanserv set $$entry(Canal (com #)) sucessor $$entry(Nick do sucessor do canal) }
  }
  ...-
  ...password:{
    if (# isin $active) { .chanserv set # password $$?*="Senha:" }
    else { .chanserv set $$entry(Canal (com #)) password $$?*="Senha:" }
  }
  ...descrição:{
    if (# isin $active) { .chanserv set # desc $$entry(Descrição:) }
    else { .chanserv set $$entry(Canal (com #)) desc $$entry(Descrição:) }
  }
  ...msg de entrada:{
  if (# isin $active) { .chanserv set # entrymsg $$entry(Mensagem de entrada:) }
  else { .chanserv set $$entry(Canal (com #)) entrymsg $$entry(Mensagem de entrada:) }
}
  ...url:{
    if (# isin $active) { .chanserv set # url $$entry(url:) }
    else { .chanserv set $$entry(Canal (com #)) url $$entry(url:) }
  }
  ...e-mail:{
    if (# isin $active) { .chanserv set # email $$entry(E-mail) }
    else { .chanserv set $$entry(Canal (com #)) email $$entry(E-mail:) }
  }
  ...tópico:{
    if (# isin $active) { .chanserv set # topic $$entry(Tópico:) }
    else { .chanserv set $$entry(Canal (com #)) topic $$entry(Tópico:) }
  }
  ...-
  ...travar topico:{
    if (# isin $active) { .chanserv set # topiclock on }
    else { .chanserv set $$entry(Canal (com #)) topiclock on }
  }
  ...destravar topico:{
    if (# isin $active) { .chanserv set # topiclock off }
    else { .chanserv set $$entry(Canal (com #)) topiclock off }
  }
  ..access
  ...add:{
    if (# isin $active) { .chanserv access # add $$entry(Nick:) $$entry(Nível) }
    else { .chanserv access $$entry(Canal (com #)) add $$entry(Nick:) $$entry(Nível) }
  }
  ...del:{
    if (# isin $active) { .chanserv access # del $$entry(Nick:) }
    else { .chanserv access $$entry(Canal (com #)) del $$entry(Nick:) }
  }
  ...list:{
    if (# isin $active) { .chanserv access # list }
    else { .chanserv access $$entry(Canal (com #)) list }
  }
  ..akick
  ...add:{
    if (# isin $active) { .chanserv akick # add $$entry(Nick e/ou mask:) $$entry(Motivo) }
    else { .chanserv akick $$entry(Canal (com #)) add $$entry(Nick e/ou mask:) $$entry(Motivo) }
  }
  ...del:{ 
    if (# isin $active) { .chanserv akick # del $$entry(Nick e/ou mask:) }
    else { .chanserv akick $$entry(Canal (com #)) del $$entry(Nick e/ou mask:) }
  }
  ...list:{
    if (# isin $active) { .chanserv akick # list }
    else { .chanserv akick $$entry(Canal (com #)) list }
  }
  .&memoserv
  ..enviar:.memoserv send $$entry(Nick ou Canal:) $$entry(Mensagem)
  ..-
  ..ler:.memoserv read $$entry(Número da mensagem:)
  ..ler novas:.memoserv read new
  ..-
  ..listar:.memoserv list
  ..listar novas:.memoserv list new
  ..-
  ..del:.memoserv del $$entry(Número da mensagem:)
  ..undel:.memoserv undel $$entry(Número da mensagem:)
  ..-
  ..del all:.memoserv del all
  -
}
; eof
