#!/usr/bin/env zsh
if [ $# -ne 1 ]
then
    echo "provide a path"
    exit 1
fi
"$1" list links | grep 'bandcamp\.com/' | sed -E 's/^\[([0-9]+:)?([0-9]+)].*$/\2/' | \
while read tabId; do
    "$1" execute '
(function () {
    var playButton = document.getElementsByClassName("playbutton")[0];
    if (playButton.className.indexOf("playing") > -1) {
        // pause
        playButton.click();
        window.thisbandcamppageisbeingcontrolledbyscripts = true;
    } else {
        // play
        if (window.thisbandcamppageisbeingcontrolledbyscripts) {
            playButton.click();
            window.thisbandcamppageisbeingcontrolledbyscripts = false;
        }
    }
})();' -t $tabId
done
