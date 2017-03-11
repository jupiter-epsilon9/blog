### Serwer
Hugo server -t hugo-redlounge --baseUrl=http://localhost -p 80


### Script for build, add, commit, push (works for new and deleted files)
```
cat << EOF > zatwierdz.sh
#!/bin/bash
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"
git add . --all
echo -ne "\e[1m\e[93mKomentarz do zmian > "
read comment1
echo -ne "\e[0m"
git commit -m "\$comment1"	
git push
EOF
chmod +x zatwierdz.sh
```

### push to FTP
``` 
git ftp push -vv --syncroot public --user ###### --passwd ##### ftpes://######/public_html
```

### Konfiguracja GIT'a
#### wyłączenie warningów CRLF
```
git config --global core.safecrlf false 
```
##### Konfiguracja push FTP
```
git clone https://github.com/git-ftp/git-ftp
cd git-ftp && chmod +x git-ftp
cp git-ftp /usr/bin/
git ftp init --user ##### --passwd ##### ftp://#####/public_html
```
