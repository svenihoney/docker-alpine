#!/bin/sh

[ -x /setup.sh ] && /setup.sh

[ $VERBOSE ] && echo "Updating permissions..."
for dir in /var/log /tmp /etc/s6.d $USERDIRS; do
  if $(find $dir ! -user $UID -o ! -group $GID|egrep '.' -q); then
    [ $VERBOSE ] && echo "Updating permissions in $dir..."
    chown -R $UID:$GID $dir
  else
    [ $VERBOSE ] && echo "Permissions in $dir are correct."
  fi
done
[ $VERBOSE ] && echo "Done updating permissions."

exec su-exec $UID:$GID /bin/s6-svscan /etc/s6.d
