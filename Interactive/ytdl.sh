#!/bin/sh

#Requirements youtube-dl, ffmpeg, axel

# ./ytdl.sh <project name> <url>

_Main() {
    # youtube-dl VARS
    YTDLpath="$HOME/files/$1"
    LOGFILE="$YTDLpath/_youtubedl.log"
    ARCHIVE="$YTDLpath/archivedytidlist.txt"
    URL="$2"

    # _userinput() {
    #     # User input
    #     echo "I need a single word that will be your folder name."
    #     read -r 'Project Name: ' PROJECT
    #     echo "Now I need your URL that I might be pulling from."
    #     read -r 'URL: ' URL
    #     sleep 2
    # }

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
        DL="axel"
        DLARGS="--num-connections=8 \
            --alternate"

        ytdlOUTPUT="$YTDLpath/%(uploader)s/%(upload_date)s_%(title)s.%(ext)s"
        ytdlARGS="--add-metadata \
            --all-subs \
            --console-title \
            --convert-subs=srt \
            --download-archive=$ARCHIVE \
            --embed-subs \
            --external-downloader-args=${DLARGS} \
            --external-downloader=${DL} \
            --fixup \
            --fragment-retries infinite \
            --hls-prefer-ffmpeg \
            --ignore-errors \
            --no-continue \
            --no-part \
            --prefer-ffmpeg \
            --retries=infinite \
            --verbose \
            --write-all-thumbnails \
            --write-annotations \
            --write-description \
            --write-info-json \
            --output=${ytdlOUTPUT}"

        parallel --delay youtube-dl $ytdlARGS {} ::: $URL
    }

    #_userinput
    _projectfolder
    _logfile
    _youtubedl
}
_Main "$@"
