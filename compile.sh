#!/bin/bash

tools="xelatex biber git grep wc qrencode"
for i in ${tools}; do
  if [ -z `which $i` ]; then
    echo "$i is not installed"
    exit 1
  fi
done

# definiciones utiles
out="latexout"
version=`git describe --always | sed 's/-/./'`
if [ `git status --porcelain | wc -l` -ne 0 ]; then
  delta="+"
fi

function callxelatex {
  while [[ ! -e $1-${out} ]] || [[ ! -z "`grep -i rerun $1-${out} | grep -v sty | grep -v biblatex`" ]]; do
    xelatex -shell-escape rvignolo-$1 | tee $1-${out}
  done
}

function callbiber {
  if [ ! -z "`grep Biber $1-${out}`" ]; then
    biber rvignolo-$1
    xelatex -shell-escape rvignolo-$1 | tee $1-${out}
    xelatex -shell-escape rvignolo-$1 | tee $1-${out}
  fi
}

# limpiamos el directorio
./clean.sh

echo -n "creating svg and pdf auxiliary files... "

# convertimos los svg
cd logos
../svg2pdf.sh
cd ..

# generamos los qr (en svg)
cd qr
./qr.sh
cd ..
echo "ok!"

for language in english; do
  rm -f ${language}-${out}
  
  callxelatex ${language}
  callbiber ${language}
  callxelatex ${language}
  
  cp rvignolo-${language}.pdf rvignolo-${language}-${version}${delta}.pdf
done

tput setaf 4
echo
echo result saved as rvignolo-english-${version}${delta}.pdf
tput sgr0
