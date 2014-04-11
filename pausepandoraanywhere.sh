#!/usr/bin/env zsh
chrome-cli list links | grep '//www\.pandora\.com/' | sed -E 's/^\[[0-9]+:([0-9]+)].*$/\1/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
(function () {
    if ($(".pauseButton").is(":visible")) {
        // pause
       $(".pauseButton").click();
        suchstupidrobustness = true;
    } else {
        // play
        if (suchstupidrobustness) {
            $(".playButton").click();
            suchstupidrobustness = false;
        }
    }
})();
EOF)" -t $tabId
done