#!/bin/bash
azul="005a9e"
magenta="90005f"

if [ -z "`which qrencode`" ]; then
  echo "qrencode not installed"
  exit 1
fi


function encode {
  qrencode -o $1.svg -t svg -m 0 -s 1 -l Q $2
  sed -i s/000000/$3/ $1.svg
}

encode wasora       https://github.com/seamplex/wasora                                                  ${magenta}
encode milonga      https://bitbucket.org/rvignolo/milonga                                              ${azul}
encode mate         https://github.com/rvignolo/mate                                                    ${magenta}
encode kosmos       https://github.com/rvignolo/kosmos                                                  ${azul}

../svg2pdf.sh
