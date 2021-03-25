#!/bin/bash

# This script is used for migrating custom configurations after system update

# Check connectivity
REMARKABLE="root@remarkable"
ssh -q $REMARKABLE exit
EXIT_STATUS=$?
if [ ${EXIT_STATUS} -eq 0 ]; then
  echo "☺ can connect to Remarkable device successfully"
  printf "\n"
else
  echo "☹ can't connect to Remarkable device"
  exit ${EXIT_STATUS}
fi

# Migrate fonts
echo "♺ Migrating fonts..."
# mkdir -p /usr/share/fonts/opentype
scp -r Fonts/opentype $REMARKABLE:/usr/share/fonts/opentype
printf "♬ Done\n\n"

# Migrate screensavers
echo "♺ Migrating screensavers..."
scp 'Screensavers/LEGO Toy Building Brick.png' $REMARKABLE:/usr/share/remarkable/suspended.png
printf "♬ Done\n\n"

# Migrate templates
echo "♺ Migrating templates..."
scp -r Templates/*.png $REMARKABLE:/usr/share/remarkable/templates
scp Templates/templates.json $REMARKABLE:/usr/share/remarkable/templates/templates.json
printf "♬ Done\n\n"

# Reboot device
echo "♺ Reboot device..."
ssh -t $REMARKABLE "systemctl restart xochitl"
