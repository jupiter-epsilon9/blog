+++
title = "Historie z wiersza poleceń"
description = ""
draft = false
date = "2013-12-01T11:12:02+01:00"

+++

## Mysql - Utworzenie bazy danych oraz użytkownika i przyznanie zestawu uprawnień

CREATE DATABASE surreal_todo ;
CREATE USER 'surreal_todo'@'localhost' IDENTIFIED BY 'haslo123';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE ON surreal_todo.* TO 'surreal_todo'@'localhost';

*nadanie dostępu z innego hosta. Mysql musi nasłuchiwać na odpowiednim interfejsie*
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON do.* to 'do'@'172.20.4.135' IDENTIFIED BY 'haslo123';


## Solaris - Wyświetlenie wolnej przestrzeni dyskowej na partycjach - w GB. Filesystem / punkt montowania / rozmiar w GB

df -k | awk '{used=$3/(1024*1024) ; print $6";"$1";"used}'       # oddzielone średnikami jak w csv
df -k | awk '{used=$3/(1024*1024) ; print $6"\t\t"$1"\t\t"used}' # oddzielone tabulatorami


## Przekopiowanie plików z wykorzystaniem tar i scp

tar -czPf -  /var/log/squid/ | ssh 172.20.4.44 "cat | tar -xzvPf -"

Zachowuje prawa dostępu i uzytkowników. Zachowuje ścieżki (parametr p) dzięki czemu pliki wylądują w tej samej lokalizacji z której były tar'owane. Pliki są kompresowane a następnie przesyłane w jednym archiwum tar, co przyspiesza kopiowanie w sytuacji w której mamy do czynienia z dużą ilością małych plików.

## Wylistowanie aplikaci wraz z portami, na których nasłuchują

netstat -tulpn

## Apache
### Polecenie wyodrębnia z dziennika serwera WWW adres IP, który więcej niż 500 razy odnotował swoją aktywność

Usunąć spację pomiędzy [ [ i ] ]

for ip in `cat access.log | cut -d ' ' -f 1 | sort | uniq`;  do { count=`grep ^$ip access.log | wc -l`;  if [ [ "$count" -gt "500" ] ]; then echo "$count: $ip"; fi }; done

### Przekierowanie z http na https
~~~
RewriteEngine on
RewriteCond %{HTTPS} !on
RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
~~~
## Prosty czat na konsoli

Okno do wpisywania komunikatów. Każdy użytkownik uruchamia poniższy skrypt
user="Jan";while true; do read msg; date=`date +"%T"`; echo "[$date] $user: $msg" >> out; done

Okno odbierania

tail -f out

Wyczyszczenie rozmowy

shred out
