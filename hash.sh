git describe --always | sed 's/-/./'
if [ `git status --porcelain | wc -l` -ne 0 ]; then
  echo "$+\Delta$"
fi
