#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel
# Fluff
echo "Hello $USER. Lets play a game."
sleep 2
echo "First things first."
sleep 1

# User input
echo "I need a single word that will be your folder name."
read -p 'Project Name: ' PROJECT
echo "Now I need your url that I might be pulling from."
read -p 'URL: ' URL
sleep 2
echo "*silently judges*"
sleep 3

# youtube-dl VARS
YTDLpath="$HOME/$PROJECT"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"
DOWNLOADER="axel"
DOWNLOADER_ARGS="-n 15"

# Creates Project folder if you dont have one.
echo "If ya didnt have a Project folder, ya got one now."
mkdir $HOME/$PROJECT
sleep 2s
# Creates inital logfile. | Overwrites existing logfile on every new script run.
echo "A wild logfile appears!"
echo 'go go gadget\n' >> $LOGFILE
echo 'go go gadget\n' >> $ARCHIVE
echo "$LOGFILE"
sleep 1s
echo "$ARCHIVE"
sleep 5s

#Fluff
echo "liftoff in"
sleep 1s
echo "3"
sleep 1s
echo "2"
sleep 1s
echo "1"
sleep 3s
echo "did you hear that?"
sleep 3s
echo "0"

# youtube-dl
youtube-dl \
--all-subs \
--buffer-size 16k \
--console-title \
--download-archive $ARCHIVE \
--external-downloader $DOWNLOADER \
--external-downloader-args "$DOWNLOADER_ARGS" \
--fragment-retries infinite \
--hls-prefer-ffmpeg \
--ignore-errors \
--no-continue \
--no-part \
-o "$YTDLpath/%(uploader)s/%(upload_date)s_%(title)s.%(ext)s" \
--playlist-random \
--prefer-ffmpeg \
--retries infinite \
--verbose \
--write-description \
--write-info-json \
--write-annotations \
--write-all-thumbnails \
"$URL" | tee --append $LOGFILE