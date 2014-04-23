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
        drunkenslowmoguy = video.currentTime;
    } else {
        // check if we paused this with js
        if (drunkenslowmoguy === video.currentTime) {
            video.play();
            drunkenslowmoguy = false;
        }
    }
})();
EOF)" -t $tabId
done

chrome-cli list links | grep '//www\.pandora\.com/' | sed -E 's/^\[[0-9]+:([0-9]+)].*$/\1/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
(function () {
    if ($(".pauseButton").is(":visible")) {
        // pause
       $(".pauseButton").click();
        thispandorabeingcontrolledbyscripts = true;
    } else {
        // play
        if (thispandorabeingcontrolledbyscripts) {
            $(".playButton").click();
            thispandorabeingcontrolledbyscripts = false;
        }
    }
})();
EOF)" -t $tabId
done

