#!/usr/bin/env zsh
chrome-cli list links | grep 'bandcamp\.com/' | sed -E 's/^\[[0-9]+:([0-9]+)].*$/\1/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
(function () {
    // only do this if there is already something playing, so we dont screw up playback that has yet to be started
    if ($(".playbutton").hasClass("playing")) {
        // take control of the tab (so play/pause will work too).
        $(".nextbutton").click();
        window.thisbandcamppageisbeingcontrolledbyscripts = true;
    }
})();
EOF)" -t $tabId
done