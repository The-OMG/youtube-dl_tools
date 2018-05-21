#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel

# youtube-dl VARS
YTDLpath="$HOME/$PROJECT"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"

function _userinput() {
  # User input
  echo "I need a single word that will be your folder name."
  read -p -r 'Project Name: ' PROJECT
  echo "Now I need your URL that I might be pulling from."
  read -p -r 'URL: ' URL
  sleep 2
}

function _projectfolder() {
  # Creates Project folder if you don't already have one.
  echo "If ya didn't have a Project folder, ya got one now."
  mkdir -p "$HOME"/"$PROJECT"
  sleep 2
}

function _logfile() {
  # Creates initial log-file. | Overwrites existing log-file on every new script run.
  echo "A wild log-file appears!"
  printf 'go go gadget\n' >>"$LOGFILE"
  printf 'go go gadget\n' >>"$ARCHIVE"
  echo "$LOGFILE"
  sleep 1
  echo "$ARCHIVE"
  sleep 5
}

function _youtubedl() {
  local DL="axel"
  local DLARGS="-n 15"
  local ytdlOUTPUT="$YTDLpath/%(uploader)s/%(upload_date)s_%(title)s.%(ext)s"
  local ytdlARGS=(
    "--add-metadata" "--all-subs" "--buffer-size 16k"
    "--console-title" "--convert-subs srt" "--download-archive $ARCHIVE"
    "--embed-subs" "--external-downloader ${DL[@]}" "--no-continue" "--no-part"
    "--external-downloader-args ${DLARGS[@]}" "--ignore-errors" "--verbose"
    "--fixup" "--fragment-retries infinite" "--hls-prefer-ffmpeg"
    "-o ${ytdlOUTPUT[@]}" "--playlist-random" "--prefer-ffmpeg"
    "--retries infinite" "--write-description" "--write-info-json"
    "--write-annotations" "--write-all-thumbnails"
  )
  youtube-dl "${ytdlARGS[@]}" "$URL" | tee --append "$LOGFILE"
}

_userinput
_projectfolder
_logfile
_youtubedl
