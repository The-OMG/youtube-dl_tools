#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel

# User input
echo "I need a single word that will be your folder name."
read -p -r 'Project Name: ' PROJECT
echo "Now I need your URL that I might be pulling from."
read -p -r 'URL: ' URL
sleep 2

# youtube-dl VARS
YTDLpath="$HOME/$PROJECT"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"
DOWNLOADER="axel"
DOWNLOADER_ARGS="-n 15"

# Creates Project folder if you don't already have one.
echo "If ya didn't have a Project folder, ya got one now."
mkdir -p "$HOME"/"$PROJECT"
sleep 2

# Creates initial log-file. | Overwrites existing log-file on every new script run.
echo "A wild log-file appears!"
printf 'go go gadget\n' >>"$LOGFILE"
printf 'go go gadget\n' >>"$ARCHIVE"
echo "$LOGFILE"
sleep 1
echo "$ARCHIVE"
sleep 5

# youtube-dl
youtube-dl \
--add-metadata \
--all-subs \
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
"$URL" | tee --append "$LOGFILE"
