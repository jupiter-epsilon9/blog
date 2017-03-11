+++
title = "Dostrajanie serwera squid"
description = "Rozwiązania problemów, jakie napotkałem podczas użytkowania serwera Squid"
date = "2013-04-03T11:35:47+01:00"
tags = [ "squid", "proxy" ]
Categories = [ "Informatyka", "Administracja" ]
banner = "../dostrajanie-serwera-squid.jpg"
+++

Moje przygody z serwerem Squid i rozwiązania problemów, jakie napotkałem podczas jego użytkowania.
Serwer Squid w wersji 3.1.10, system operacyjny CentOS6.



<!--more-->
## Komunikat "possible SYN flooding"
*kernel: possible SYN flooding on port 3128. Sending cookies.*
 
Wiadomość pojawia się, gdy kolejka *SYN backlog* jest pełna. Jeżeli nie jest to atak *SYN flood*, tylko na serwerze jest duży ruch, to należy zwiększyć tcp_max_syn_backlog.
 
~~~
[root@proxy ~]# cat /proc/sys/net/ipv4/tcp_max_syn_backlog
262144
~~~

## Błędy "Page Allocation Failure"

*swapper: page allocation failure. order:1, mode:0x20*

Rozwiązane poprzez zwiększenie parametru min_free_kbytes

~~~
[root@proxy ~]# echo 540732 > /proc/sys/vm/min_free_kbytes
~~~

> Re: Problems with swap? "swapper: page allocation failure. order:3, mode:0x4020"

> teddy_bteddy_b 29 Oct 2010, 21:09

> The page allocation failures are not just happening out of nowhere… When posting about such issues, it
> would help to tell what you run either on your router, or on the connected clients, and what is your
> router model. The most probable reason for these errors are running unrestricted torrents (which is
> never a good idea), or other network activity generating lots and lots of connections and making NAT
> to work hard.

> The best way to deal with these errors is to put restrictions on the processes that cause them - i.e.
> for torrents it's to limit the number of connections and bandwidth. If you're unable or not willing to
> make these restrictions for any reason, you can also try to increase the value in
> "/proc/sys/vm/min_free_kbytes" - that should help to reduce the number of these errors (the more the
> number, the less errors you will see, but it will also decrease the memory available for user space
> applications).

## Komunikat "Protocol not available" w cache.log Squid'a

*/var/log/squid/cache.log*

```
2011/01/04 11:03:38| IpIntercept.cc(137) NetfilterInterception: NF getsockopt(SO_ORIGINAL_DST) failed" on FD 12: (92) Protocol not available
```

Problem pojawia się w przypadku gdy NAT jest na innym hoście niż SQUID. Poleca się instalować squid oraz NAT na tym samym hoscie. Załadowanie modułu śledzącego połączenia rozwiązało problem i komunikat zniknął.
~~~
modprobe ip_conntrack
~~~

## Komunikat nf_conntrack: table full, dropping packet

*nf_conntrack: table full, dropping packet*

~~~
[root@proxy ~]# echo 131072 > /proc/sys/net/nf_conntrack_max
[root@proxy ~]# echo 240 >  /proc/sys/net/netfilter/nf_conntrack_generic_timeout
[root@proxy ~]# echo 108000 >  /proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established
~~~

## Zbyt mała ilość deskryptorów

*WARNING! Your cache is running out of filedescriptors*

Należy **zwiększyć** ilość deskryptorów w systemie i w Squid'zie:

~~~
vi /etc/security/limits.conf

dodano limit 32768
*               -       nofile          32768
~~~

Wylogowanie/zalogowanie do konsoli

~~~
# ulimit -a | grep 'open files'
open files                      (-n) 32768
vi /etc/squid/squid.conf
max_filedesc 24567
~~~

## Ostrzeżenie "Disk space over limit"

W logach pojawił się komunikat świadczący o tym, że cache squida jest większe niż przydzielona wielkość.

*WARNING: Disk space over limit: 16777424 KB > 16777216 KB*

http://bugs.contribs.org/show_bug.cgi?id=664 <br> 
http://bugs.contribs.org/show_bug.cgi?id=664#c3

Komunikat oznacza, że rozmiar cache jest większy od ustawionego w konfiguracji. Być może na skutek nieprawidłowego zamknięcia Squid nie ma w bazie informacji o wszystkich plikach, które są w cache.

Problem można rozwiązać np poprzez zwiększenie pojemności cache
~~~
vi /etc/squid/squid.conf
cache_dir aufs /cache 32768 32 512
~~~

## Wszystkie sockety zostały zużyte

*CommBind: Cannot bind socket FD 98 to \*:0: (98) Address already in use*

Należy zwiększyć zakres dostępnych portów. Od 1024 do 65000
~~~
net.ipv4.ip_local_port_range=1024 65000
~~~

## Ustawienia TCP_KEEPALIVE

http://tldp.org/HOWTO/TCP-Keepalive-HOWTO/usingkeepalive.html

~~~
echo 60 > /proc/sys/net/ipv4/tcp_keepalive_time
echo 3 > /proc/sys/net/ipv4/tcp_keepalive_probes
echo 50 > /proc/sys/net/ipv4/tcp_keepalive_intvl
~~~
Jeżeli połączenie nie odpowiada przez 60 sekund zacznij wysyłać próby, łącznie 3 co 50 sekund. Jeżeli żadna się nie powiedzie, to uznaj połączenie za martwe. 

Ustawienie na stałę w /etc/sysctl.conf
~~~
net.ipv4.tcp_keepalive_time = 60
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl = 50
~~~

*obrazek w nagłówku: www.cwcs.co.uk*


