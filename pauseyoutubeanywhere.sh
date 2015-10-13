#!/usr/bin/env zsh
if [ $# -ne 1 ]
then
    echo "provide a path"
    exit 1
fi
"$1" list links | grep 'https://www\.youtube\.com/watch' | sed -E 's/^\[([0-9]+:)?([0-9]+)].*$/\2/' | \
while read tabId; do
    "$1" execute '
(function () {
    var video = document.getElementsByTagName("video")[0];
    if (!video.paused) {
        // we should pause this video and save the fact that we did
        // pause
        video.pause();
        window.drunkenslowmoguy = video.currentTime;
    } else {
        // check if we paused this with js
        if (window.drunkenslowmoguy === video.currentTime) {
            video.play();
            window.drunkenslowmoguy = false;
        }
    }
})();' -t $tabId
done


