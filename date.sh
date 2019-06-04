git log --pretty=format:"%ad" --date=short | head -n1 | awk -F '-' '{printf("\\formatdate{%d}{%d}{%d}", $3, $2, $1)}'
