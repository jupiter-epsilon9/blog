#!/bin/bash
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"
git add . --all
echo -ne "\e[1m\e[93mKomentarz do zmian > "
read comment1
echo -ne "\e[0m"
git commit -m "$comment1"
git push
