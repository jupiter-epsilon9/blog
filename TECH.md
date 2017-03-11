# Przydatne polecenia

## GIT
git ftp push -vv --syncroot public --user ***** --passwd ****** ftpes://******/public_html

## Hugo 

### Serwer
Hugo server -t hugo-redlounge --baseUrl=http://localhost -p 80

### Build
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"

### add, commit, push (works for new and deleted files) 
git add . --all
git commit -m "fix"
git push