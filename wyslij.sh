#!/bin/bash
git ftp push --syncroot public
if [ $? -eq 8 ]; then
       echo -e "\e[1m\e[31mBłąd przy wysyłaniu. Sprubuj uruchomić ./zatwierdz.sh\e[0m"
fi
