; - identifiers do script
alias pcon return $duration($calc($ticks / 1000))
alias percent return $round($calc(($1 * 100) / $2),0)
alias mail return MrPrompt@bol.com.br
alias nicks return $gettok(%nicks,$1,44)
alias sep return %sep
alias site return http://www.iee.rg3.net/
alias tamarq return $bytes($lof($1-),k) $+ Kbytes
alias ver return #IEE 2.2 [beta] by MrPrompt & Blaster
alias ver² return 2.2
alias author return MrPrompt & Blaster
alias winver return Win $+ $os ( $+ $readini c:\msdos.sys Options winver $+ )
alias windir return $readini c:\msdos.sys Paths WinDir
alias x return %prefixo
alias motd { var %_motd $readini $mircini options n1 | var %__motd $gettok(%_motd,11,44) | if (%__motd == 1) return 1 | if (%__motd == 0) return 0 }
alias ieelogo return ..(12#IEE)..
alias canais return $gettok(%canais,$1,44)
alias servers return $gettok(%servers,$1,44)
; eof
