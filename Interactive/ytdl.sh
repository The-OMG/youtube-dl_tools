#!/bin/bash
#Requirements youtube-dl, ffmpeg, axel

# ./ytdl.sh <project name> <url>

_Main() {
  # youtube-dl VARS
  local YTDLpath="$HOME/files/$1"
  local LOGFILE="$YTDLpath/_youtubedl.log"
  local ARCHIVE="$YTDLpath/archivedytidlist.txt"
  local URL="$2"

  _userinput() {
    # User input
    echo "I need a single word that will be your folder name."
    read -p -r 'Project Name: ' PROJECT
    echo "Now I need your URL that I might be pulling from."
    read -p -r 'URL: ' URL
    sleep 2
  }

  _projectfolder() {
    # Creates Project folder if you don't already have one.
    echo "If ya didn't have a Project folder, ya got one now."
    mkdir -p "$YTDLpath"
    sleep 2
  }

  _logfile() {
    # Creates initial log-file. | Overwrites existing log-file on every new script run.
    echo "A wild log-file appears!"
    echo "" >>"$LOGFILE"
    echo "" >>"$ARCHIVE"
    echo "$LOGFILE"
    sleep 1
    echo "$ARCHIVE"
    sleep 5
  }

  _youtubedl() {
    local DL="axel"
    local DLARGS=(
      "--num-connections=8"
      "--alternate"
    )
    local ytdlOUTPUT="$YTDLpath/%(uploader)s/%(upload_date)s_%(title)s.%(ext)s"
    local ytdlARGS=(
      "--add-metadata"
      "--all-subs"
      "--console-title"
      "--convert-subs=srt"
      "--download-archive=$ARCHIVE"
      "--embed-subs"
      "--external-downloader-args=${DLARGS[*]}"
      "--external-downloader=${DL}"
      "--fixup"
      "--fragment-retries infinite"
      "--hls-prefer-ffmpeg"
      "--ignore-errors"
      "--no-continue"
      "--no-part"
      "--prefer-ffmpeg"
      "--retries=infinite"
      "--verbose"
      "--write-all-thumbnails"
      "--write-annotations"
      "--write-description"
      "--write-info-json"
      "--output=${ytdlOUTPUT}"
    )
    youtube-dl "${ytdlARGS[@]}" "$URL"
  }

  #_userinput
  _projectfolder
  _logfile
  _youtubedl
}
_Main "$@"
