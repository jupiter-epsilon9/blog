# Przydatne polecenia

### Serwer
Hugo server -t hugo-redlounge --baseUrl=http://localhost -p 8080


### build, add, commit, push (works for new and deleted files), push to FTP 
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"
git add . --all
git commit -m "fix"
git push
git ftp push -vv --syncroot public --user ***** --passwd ****** ftpes://******/public_html
