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
    // only do this if there is already something playing, so we dont screw up playback that has yet to be started
    if ($(".playbutton").hasClass("playing")) {
        // take control of the tab (so play/pause will work too).
        $(".nextbutton").click();
        window.thisbandcamppageisbeingcontrolledbyscripts = true;
    }
})();' -t $tabId
done