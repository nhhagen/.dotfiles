#!/usr/bin/env bash

# change to proper directory
cd /Applications/OneDrive.app/Contents/Resources/

# back up the files
sudo mkdir icon-backups
sudo cp StatusIcon_*.tiff icon-backups/

# replace all versions with the "selected" icon

# alert
for idx in {1,2,3,4,5,6,7,8,9,10,11,12,13}
do
	sudo cp "StatusIcon_selected.tiff" "StatusIcon_alert_anim$idx.tiff"
done

sudo cp "StatusIcon_selected.tiff" "StatusIcon_alert_signedin.tiff"

# anim
for idx in {1,2,3,4,5,6,7,8,9,10,11,12,13}
do
	sudo cp "StatusIcon_selected.tiff" "StatusIcon_anim$idx.tiff"
done

# signed in
sudo cp "StatusIcon_selected.tiff" "StatusIcon_signedin.tiff"

# signed out
sudo cp "StatusIcon_alert_signedin.tiff" "StatusIcon_signedout.tiff"
