#!/bin/sh
# Functions that are for osx.
# Some of thesee function are from here: https://github.com/mathiasbynens/dotfiles/blob/master/.functions

# Add note to Notes.app (OS X 10.8)
# Usage: `note 'title' 'body'` or `echo 'body' | note`
# Title is optional
#function note() {
#    local title
#    local body
#    if [ -t 0 ]; then
#        title="$1"
#        body="$2"
#    else
#        title=$(cat)
#    fi
#  osascript >/dev/null <<EOF
#tell application "Notes"
#    tell account "iCloud"
#          tell folder "Notes"
#               make new note with properties {name:"$title", body:"$title" & "<br><br>" & "$body"}
#          end tell
#    end tell
#end tell
#EOF
#}

# Add reminder to Reminders.app (OS X 10.8)
# Usage: `remind 'foo'` or `echo 'foo' | remind`
#function remind() {
#local text
#if [ -t 0 ]; then
#    text="$1" # argument
#else
#    text=$(cat) # pipe
#fi
#osascript >/dev/null <<EOF
#tell application "Reminders"
#     tell the default list
#          make new reminder with properties {name:"$text"}
#     end tell
#end tell
#EOF
#}

# Manually remove a downloaded app or file from the quarantine
function unquarantine() {
    for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
        xattr -r -d "$attribute" "$@"
    done
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# iterm coloring
function tab-color() {
    if [[ $# == 1 ]]
    then
        # convert hex to decimal
        hex=$1
        if [[ ${hex:0:1} == "#" ]]
        then
            # strip leading hash sign
            hex=${hex:1:6}
        fi
        if [[ ${#hex} == 3 ]]
        then
            # handle 3-letter hex codes
            hex="${hex:0:1}${hex:0:1}${hex:1:1}${hex:1:1}${hex:2:1}${hex:2:1}"
        fi
        r=$(printf "%d" 0x${hex:0:2})
        g=$(printf "%d" 0x${hex:2:2})
        b=$(printf "%d" 0x${hex:4:2})
    else
        r=$1
        g=$2
        b=$3
    fi
    echo -ne "\033]6;1;bg;red;brightness;$r\a"
    echo -ne "\033]6;1;bg;green;brightness;$g\a"
    echo -ne "\033]6;1;bg;blue;brightness;$b\a"
}

# Functions for changing iterm2 tab colors.
# http://kendsnyder.com/tab-colors-in-iterm2-v10/
function tab-red() { tab-color 203 111 111; }
function tab-green() { tab-color 6cc276; }
function tab-yellow() { tab-color "#e8e9ac"; }
function tab-blue() { tab-color 6f8ccc; }
function tab-purple() { tab-color a789d4; }
function tab-orange() { tab-color fbbc79; }
function tab-white() { tab-color fff; }
function tab-gray() { tab-color c3c3c3c; }
function tab-default() { tab-color c3c3c3c; }
