hg log -r tip --template '{date|shortdate}' | awk -F '-' '{printf("\\formatdate{%d}{%d}{%d}", $3, $2, $1)}'
