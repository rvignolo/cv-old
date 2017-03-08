#!/usr/bin/awk -f
/@.*/ {
  split($0, array, "{");
  key = substr(array[2], 1, length(array[2])-1);
  bib[key, type] = substr(array[1], 2);
  
  FS="=";
  getline;
  while ($0 != "}") {
    gsub(/^[ \t]+/,"",$1);
    gsub(/[ \t]+$/,"",$1);
    gsub(/^[ \t]+/,"",$2);
    gsub(/[ \t]+$/,"",$2);
    gsub(/{/,"",$2);
    gsub(/}/,"",$2);
    gsub(/"/,"",$2);
    gsub(/"/,"",$2);
    
    bib[key,$1] = substr($2, 1, length($2)-1);
    getline;
  }
  
  printf("\\report{%s}{%s, %s}{%s}", bib[key,"year"], bib[key,"author"], bib[key,"institution"], bib[key,"title"]);
  printf("{%s", bib[key,"journaltitle"]);
  if (bib[key,"number"] != "") {
    printf(" %s ", bib[key,"number"]);
  }
  if (bib[key,"url"] != "") {
    printf("}{%s}{%s}\n\n", bib[key,"url"], key);
    command = sprintf("qrencode -o qr/%s.svg -t svg -m 0 -s 1 -l Q %s; sed -i s/000000/%s/ qr/%s.svg", key, bib[key,"url"], ((n++)%2)?"90005f":"005a9e", key);
    system(command);
  } else {
    printf("}{}{}\n\n");
  }
  
}
