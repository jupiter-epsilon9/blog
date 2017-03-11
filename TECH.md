### Serwer
Hugo server -t hugo-redlounge --baseUrl=http://localhost -p 80


### build, add, commit, push (works for new and deleted files), push to FTP 
cat << EOF > zatwierdz.sh
#!/bin/bash
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"
git add . --all
echo -n "Komentarz do zmian > "
read comment1
git commit -m "\$comment1"	
git push
EOF
chmod +x zatwierdz.sh

git ftp push -vv --syncroot public --user ###### --passwd ##### ftpes://######/public_html


### Konfiguracja GIT'a
##### wyłączenie warningów CRLF
git config --global core.safecrlf false 