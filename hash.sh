hg log -r tip --template '{rev}:{node|short}'
if [ ! -z "`hg status`" ]; then
  echo "$+\Delta$"
fi
