cc -o templater mymain.c `perl -MExtUtils::Embed -e ccopts -e ldopts`
./templater myPlugin mytest.tmpl ./
rm -r templater*
