#!/bin/bash
tools="xelatex biber hg grep wc qrencode"
for i in ${tools}; do
  if [ -z `which $i` ]; then
    echo "$i is not installed"
    exit 1
  fi
done

function callxelatex {
  while [[ ! -e ${out} ]] || [[ ! -z "`grep -i rerun ${out} | grep -v sty | grep -v biblatex`" ]]; do
    xelatex -shell-escape rvignolo | tee ${out}
  done
}

function callbiber {
  if [ ! -z "`grep Biber ${out}`" ]; then
    biber rvignolo
    xelatex -shell-escape rvignolo | tee ${out}
    xelatex -shell-escape rvignolo | tee ${out}
  fi
}

cd qr
./qr.sh
cd ..

out="latexout"
rm -f ${out}

callxelatex
callbiber
callxelatex
rm ${out}

version=`hg log -r tip --template '{rev}-{date|shortdate}'`
if [ ! -z "`hg status`" ]; then
  delta="+"
fi

cp rvignolo.pdf rvignolo-${version}${delta}.pdf
echo
echo result saved as rvignolo-${version}${delta}.pdf
