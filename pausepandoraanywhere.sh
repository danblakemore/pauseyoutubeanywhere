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
    if ($(".pauseButton").is(":visible")) {
        // pause
       $(".pauseButton").click();
        window.thispandorabeingcontrolledbyscripts = true;
    } else {
        // play
        if (window.thispandorabeingcontrolledbyscripts) {
            $(".playButton").click();
            window.thispandorabeingcontrolledbyscripts = false;
        }
    }
})();' -t $tabId
done