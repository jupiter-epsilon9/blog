#!/bin/bash
git ftp push --syncroot public
if [ $? -eq "8" ]; then
        echo -e "\e[1m\e[31mBłąd przy wysyłaniu na serwer. Spróbuj uruchomić ./zatwierdz.sh\e[0m"
elif [ $? -eq "0" ] ; then
        echo "Wysłano."
else
        echo -e "\e[1m\e[31mBłąd przy wysyłaniu na serwer.\e[0m"
fi
