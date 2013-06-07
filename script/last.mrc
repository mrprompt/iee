; -- iee script - últimas rotinas
;
on *:start:{
  .timertitlebar 0 1 tt
  echo $colour(Normal Text) -tms $x $sep
  echo $colour(Normal Text) -tms $x $ver
  echo $colour(Normal Text) -tms $x Nick: $me - início no: %load.times
  echo -tms $x $sep
  if ($window(@Splash)) window -c @Splash
  if ($readini(script\options.ini,others,servers.dlg) == 1) .dlgservers
}
; eof
