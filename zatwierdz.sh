    #!/bin/bash
hugo -t hugo-redlounge -b "http://jupiter.098.pl/"
git add . --all
echo -n "Komentarz do zmian > "
read comment
git commit -m "git commit -m "$comment"git pushFix"
git push
