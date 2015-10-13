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
    if ($(".playbutton").hasClass("playing")) {
        // pause
        $(".playbutton").click();
        window.thisbandcamppageisbeingcontrolledbyscripts = true;
    } else {
        // play
        if (window.thisbandcamppageisbeingcontrolledbyscripts) {
            $(".playbutton").click();
            window.thisbandcamppageisbeingcontrolledbyscripts = false;
        }
    }
})();' -t $tabId
done
