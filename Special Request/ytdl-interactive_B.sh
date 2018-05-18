#!/bin/bash

#Requirements youtube-dl, ffmpeg, axel

# youtube-dl VARS
YTDLpath="$HOME/$PROJECT"
LOGFILE="$YTDLpath/_youtubedl.log"
ARCHIVE="$YTDLpath/archivedytidlist.txt"
DOWNLOADER="axel"
DOWNLOADER_ARGS="-n 15"

function _greeting() {
  echo "Hello $USER. Lets play a game."
  sleep 2
  echo "First things first."
  sleep 1
}

function _userINPUT() {
  echo "I need a single word that will be your folder name."
  read -p 'Project Name: ' PROJECT
  echo "Now I need your url that I might be pulling from."
  read -p 'URL: ' URL
  sleep 2
  echo "*silently judges*"
  sleep 3
}

# Creates Project folder if you dont have one.
function _projectpath() {
  echo "If ya didnt have a Project folder, ya got one now."
  mkdir "$YTDLpath"
  sleep 2s
}

# Creates inital logfile. | Overwrites existing logfile on every new script run.
function _logfile() {
  echo "A wild logfile appears!"
  echo "go go gadget" >"$LOGFILE"
  echo "go go gadget" >"$ARCHIVE"
  echo "$LOGFILE"
  sleep 1s
  echo "$ARCHIVE"
  sleep 5s
}

function _ytdl() {
  local YTDLARGS=(
    "--all-subs"
    "--buffer-size=16k"
    "--console-title"
    "--download-archive=$ARCHIVE"
    "--external-downloader=$DOWNLOADER"
    "--external-downloader-args=$DOWNLOADER_ARGS"
    "--fragment-retries=infinite"
    "--hls-prefer-ffmpeg"
    "--ignore-errors"
    "--no-continue"
    "--no-part"
    "-o=$YTDLpath/%(uploader)s/%(upload_date)s_%(title)s.%(ext)s"
    "--playlist-random"
    "--prefer-ffmpeg"
    "--retries=infinite"
    "--verbose"
    "--write-description"
    "--write-info-json"
    "--write-annotations"
    "--write-all-thumbnails"
  )
  youtube-dl "${YTDLARGS[@]}" "$URL" | tee --append "$LOGFILE"
}

_greeting
_userINPUT
_projectpath
_logfile
_ytdl
