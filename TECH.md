# Serwer
```
Hugo server -t hugo-redlounge --baseUrl=http://localhost -p 80
```

# Script for build, add, commit, push (works for new and deleted files)
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
 
# push to FTP
``` 
cat << EOF > wyslij.sh
#!/bin/bash
	git ftp push --syncroot public
	if [ \$? -eq 8 ]; then
       echo -e "\e[1m\e[31mBłąd przy wysyłaniu. Sprubuj uruchomić ./zatwierdz.sh\e[0m"	
	fi
EOF
chmod +x wyslij.sh
./wyslij.sh
```

# Konfiguracja GITa

## konfiguraca repo na GitHUB
```
git config --global credential.helper wincred
git config --global credential.helper 'cache --timeout 7200'
git push https://github.com/repo.git

Username for 'https://github.com': <USERNAME>
Password for 'https://USERNAME@github.com': <PASSWORD>
```
 
## wyłączenie warningów CRLF
```
git config --global core.safecrlf false 
```
## Konfiguracja push FTP
```
git clone https://github.com/git-ftp/git-ftp
chmod +x git-ftp/git-ftp
cp git-ftp/git-ftp /bin
```

Zapisanie url, login i haseł czystym tekstem w lokalnym repo.
```
git config git-ftp.url ftpes://ftp.example.net/public_html
git config git-ftp.user ftp-user
git config git-ftp.password secr3t
```

Podanie poświadczeń z linii poleceń bez zapisywania
```
git ftp push --syncroot public --user #### --passwd #### ftp://####/public_html
```

Inicjalizacja
```
git ftp init 
```

# Przydatne polecenia *git*
## Informacja o repozytoriach
```
git remote -v  
git remote show -n origin
git config --get remote.origin.url
```

# Pobranie z repo gita i uruchomienie edytora
```
cat << EOF > edytuj.sh
#!/bin/bash
	git pull
	if [ \$? -ne 0 ]; then
        echo -e "\e[1m\e[31mBłąd aktualizacji repozytorium GIT\e[0m"
        exit
	fi
	cmd "/C start /I C:/\"Program Files (x86)/MarkdownPad 2\"/MarkdownPad2.exe" &
	cmd "/C start /I C:/\"Program Files (x86)/Google/Chrome/Application\"/chrome.exe http://localhost/"	&
	hugo server -t hugo-redlounge -p 80 -b "http://localhost/"
EOF
chmod +x edytuj.sh
./edytuj.sh
```


# Highlight.js

https://highlightjs.org/static/demo/
https://highlightjs.org/download/
https://highlightjs.org/usage/
https://github.com/isagalaev/highlight.js/tree/master/src/styles
