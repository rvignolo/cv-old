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

encode aatn-2016-3  https://bitbucket.org/rvignolo/aatn-2016-moc-milonga                                ${magenta}
encode aatn-2016-2  https://bitbucket.org/rvignolo/aatn-2016-appl-multi-xs                              ${azul}
encode aatn-2016-1  https://bitbucket.org/rvignolo/aatn-2016-xs-multitabla                              ${magenta}
encode aatn-2015    https://bitbucket.org/rvignolo/aatn-2015-ext-ins-eecc                               ${azul}
encode igorr-2014   http://www.igorr.com/scripts/home/publigen/content/templates/Show.asp?P=1000\&L=EN  ${magenta}
encode tesis-ib     http://ricabib.cab.cnea.gov.ar/467/                                                 ${azul}

encode garcar-2016-2     https://bitbucket.org/rvignolo/taller-dragon-garcar-2016                       ${magenta}
encode garcar-2016-1     https://bitbucket.org/rvignolo/aatn-2016-moc-milonga-presentacion              ${azul}
encode aatn-2016-1-pres  https://bitbucket.org/rvignolo/aatn-2016-xs-multitabla-presentacion            ${magenta}
encode aatn-2016-2-pres  https://bitbucket.org/rvignolo/aatn-2016-appl-multi-xs-presentacion            ${azul}
encode aatn-2016-3-pres  https://bitbucket.org/rvignolo/aatn-2016-moc-milonga-presentacion              ${magenta}

encode wasora       https://bitbucket.org/seamplex/wasora                                                 ${magenta}
encode milonga      https://bitbucket.org/rvignolo/milonga                                              ${azul}

../svg2pdf.sh
