#!/bin/bash
    git pull
if [ $? -ne 0 ]; then
    echo "Błąd aktualizacji repozytorium GIT"
exit
    fi
cmd "/C start /I C:/\"Program Files (x86)/MarkdownPad 2\"/MarkdownPad2.exe"
cmd "/C start /I C:/\"Program Files (x86)/Google/Chrome/Application\"/chrome.exe http://localhost/"
hugo server -t hugo-redlounge -p 80 -b "http://localhost/"
