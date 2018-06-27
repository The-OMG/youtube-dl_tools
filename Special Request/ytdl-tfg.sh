#!/bin/bash
url="$1"
type="$2"
youtube-dl -j --flat-playlist https://www.youtube.com/"$type"/"$url" | jq -r '.id' | sed 's_^_youtube-dl --verbose --ignore-errors --no-continue --no-overwrites --no-post-overwrites --download-archive archive.txt --write-description --write-info-json --write-annotations --write-all-thumbnail --all-subs --convert-subs srt --add-metadata --output "%(uploader)s/%(upload_date)s - %(title)s - %(id)s/%(title)s.%(ext)s" -f \("bestvideo[width>=1920]"/bestvideo\)+bestaudio/best --merge-output-format mkv https://youtube.com/v/_' >> "$url"
parallel -j12 :::: "$url"
