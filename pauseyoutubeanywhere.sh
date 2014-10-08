#!/usr/bin/env zsh
chrome-cli list links | grep 'https://www\.youtube\.com/watch' | sed -E 's/^\[[0-9]+:([0-9]+)].*$/\1/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
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
})();
EOF)" -t $tabId
done


