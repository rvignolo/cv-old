#!/bin/bash

tools="xelatex biber hg grep wc qrencode"
for i in ${tools}; do
  if [ -z `which $i` ]; then
    echo "$i is not installed"
    exit 1
  fi
done

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

# convertimos los svg
cd logos
../svg2pdf.sh
cd ..

# generamos los qr
cd qr
./qr.sh
cd ..

# definiciones utiles
out="latexout"
version=`hg log -r tip --template '{rev}-{date|shortdate}'`
if [ ! -z "`hg status`" ]; then
  delta="+"
fi

for language in english spanish; do
  rm -f ${language}-${out}
  
  callxelatex ${language}
  callbiber ${language}
  callxelatex ${language}
  
  cp rvignolo-${language}.pdf rvignolo-${language}-${version}${delta}.pdf
done

echo
echo result saved as rvignolo-english-${version}${delta}.pdf
echo result saved as rvignolo-spanish-${version}${delta}.pdf