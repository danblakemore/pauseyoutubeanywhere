#!/usr/bin/env zsh
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