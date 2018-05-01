#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel

# youtube-dl VARS
YTDLpath="/home/mc2/DataHoarding/Archives"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"
DOWNLOADER="aria2c"
DOWNLOADER_ARGS="-x -j 20 -s 20 -x 16 -k 6M"
URL="https://www.youtube.com/playlist?list=PLTHOlLMWEwVy52FUngq91krMkQDQBagYw"

# Creates Project folder if you dont have one.
echo "If ya didnt have a Project folder, ya got one now."
mkdir "$HOME"/"$PROJECT"
sleep 2s
# Creates inital logfile. | Overwrites existing logfile on every new script run.
echo "A wild logfile appears!"
printf 'go go gadget\n' >>$LOGFILE
printf 'go go gadget\n' >>$ARCHIVE
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
YTDL="(
  youtube-dl \
  --all-subs \
  --buffer-size 16k \
  --console-title \
  --download-archive $ARCHIVE \
  --embed-subs
  --external-downloader $DOWNLOADER \
  --external-downloader-args "$DOWNLOADER_ARGS" \
  --fragment-retries infinite \
  --hls-prefer-ffmpeg \
  --ignore-errors \
  --no-continue \
  --no-part \
  -o "$YTDLpath/%(uploader)s/%(id)s/%(upload_date)s - %(title)s/%(title)s.%(ext)s" \
  --playlist-random \
  --prefer-ffmpeg \
  --retries infinite \
  --verbose \
  --write-description \
  --write-info-json \
  --write-annotations \
  --write-thumbnail \
  --write-all-thumbnails \
  "$URL" | tee --append $LOGFILE \
)"

$YTDL
