#!/usr/bin/env bash

# Requirements: youtube-dl

# Global Vars
PROJECT='Pluralsight'

# Global directories
ytdlPATH="$HOME/$PROJECT"
logPATH="$ytdlPATH/_LOGS"

# Global logs
OPERATIONLOG="$logPATH/ytdl-Pluralsight.log"

function _logfolder() {
  # Create log folder location if necessary.
  if [ ! -d "$logPATH" ]; then
    echo "Creating project log folder" | tee -a "$OPERATIONLOG"
    mkdir -p "$logPATH"
  fi
}

function _ytdl() {
  local URLS
  URLS=$(curl https://raw.githubusercontent.com/The-OMG/youtube-dl_tools/master/Pluralsight/Pluralsight_coding_and_hardware_URLS.txt)
  local LOGFILE="$ytdlPATH/ytdl.log"
  local ARCHIVE="$ytdlPATH/ytdl-archive.txt"
  local pluralUSER='omg'
  local pluralPASS='omgsCoolPass'
  local proxyEMAIL='mrHaxor@aol.com'
  local proxyPASS='HaxorPass'


  ytdlARGS=(
    "--add-metadata"
    "--all-subs"
    "--batch-file $URLS"
    "--buffer-size 16k"
    "--console-title"
    "--convert-subs srt"
    "--download-archive $ARCHIVE"
    "--embed-subs"
    "--fixup"
    "--fragment-retries infinite"
    "--hls-prefer-ffmpeg"
    "--ignore-errors"
    "--max-sleep-interval 60"
    "--min-sleep-interval 50"
    "--no-continue"
    "--password $pluralPASS"
    "--playlist-start 60"
    "--prefer-ffmpeg"
    "--proxy=http://$proxyEMAIL:$proxyPASS@fi10.nordvpn.com:80"
    "--retries infinite"
    "--username $pluralUSER"
    "--verbose"
    "--write-all-thumbnails"
    "--write-annotations"
    "--write-description"
    "--write-info-json"
    "-o %(playlist)s/%(chapter_number)s. %(chapter)s/%(playlist_index)s. %(title)s.%(ext)s"
  )

  youtube-dl "${ytdlARGS[@]}" | tee --append "$LOGFILE"
}
