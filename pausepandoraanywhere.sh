#!/usr/bin/env zsh
if [ $# -ne 1 ]
then
    echo "provide a path"
    exit 1
fi
"$1" list links | grep '//www\.pandora\.com/' | sed -E 's/^\[([0-9]+:)?([0-9]+)].*$/\2/' | \
while read tabId; do
    "$1" execute '
(function () {
    var pauseButton = document.getElementsByClassName("pauseButton")[0];
    var playButton = document.getElementsByClassName("playButton")[0];
    // manually determine visibility because no jquery
    // http://stackoverflow.com/a/14122186
    if (pauseButton.offsetWidth !== 0 && pauseButton.offsetHeight !== 0) {
        // pause
       pauseButton.click();
        window.thispandorabeingcontrolledbyscripts = true;
    } else {
        // play
        if (window.thispandorabeingcontrolledbyscripts) {
            playButton.click();
            window.thispandorabeingcontrolledbyscripts = false;
        }
    }
})();' -t $tabId
done