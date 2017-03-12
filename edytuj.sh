#!/bin/bash
git pull
if [ $? -ne 0 ]; then
        echo -e "\e[1m\e[31Błąd aktualizacji repozytorium GIT\e[0m"
        exit
fi
cmd "/C start /I C:/\"Program Files (x86)/MarkdownPad 2\"/MarkdownPad2.exe" &
cmd "/C start /I C:/\"Program Files (x86)/Google/Chrome/Application\"/chrome.exe http://localhost/"&
hugo server -t hugo-redlounge -p 80 -b "http://localhost/"
