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
git ftp push --syncroot public 
```

# Konfiguracja GITa
## konfiguraca repo na GitHUB
```
git config --global credential.helper store
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
cp git-ftp/git-ftp /usr/bin/

git config git-ftp.url ftpes://ftp.example.net/public_html
git config git-ftp.user ftp-user
git config git-ftp.password secr3t

git ftp init 
```

# Przydatne polecenia *git*
## Informacja o repozytoriach
```
git remote -v  
git remote show -n origin
git config --get remote.origin.url
```