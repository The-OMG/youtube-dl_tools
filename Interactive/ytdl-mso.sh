#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel

# User input
read -p 'URL: ' URL
sleep 2

# youtube-dl VARS
YTDLpath="$HOME/$PROJECT"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"
DOWNLOADER="axel"
DOWNLOADER_ARGS="-n 15"
PROJECT="Comedy_Central"
MSO="gci"
APU="ogrimm"

# Creates Project folder if you dont have one.
echo "If ya didnt have a Project folder, ya got one now."
mkdir -p $HOME/$PROJECT
sleep 2

# Creates inital logfile. | Overwrites existing logfile on every new script run.
echo "A wild logfile appears!"
echo 'go go gadget\n' >> $LOGFILE
echo 'go go gadget\n' >> $ARCHIVE
echo "$LOGFILE"
sleep 1
echo "$ARCHIVE"
sleep 5

# youtube-dl
youtube-dl \
--add-metadata \
--all-subs \
--ap-mso $MSO \
--ap-username $APU \
--buffer-size 16k \
--console-title \
--convert-subs srt \
--download-archive $ARCHIVE \
--embed-subs \
--external-downloader $DOWNLOADER \
--external-downloader-args "$DOWNLOADER_ARGS" \
--fixup \
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