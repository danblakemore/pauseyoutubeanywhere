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
    // only skip if playing so we dont waste skips
    var pauseButton = document.getElementsByClassName("pauseButton")[0];
    var skipButton = document.getElementsByClassName("skipButton")[0];
    if (pauseButton.offsetWidth !== 0 && pauseButton.offsetHeight !== 0) {
        // just take control of the tab (so play/pause will work too).
        skipButton.click();
        window.thispandorabeingcontrolledbyscripts = true;
    }
})();' -t $tabId
done