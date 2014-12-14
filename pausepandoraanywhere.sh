#!/usr/bin/env zsh
chrome-cli list links | grep '//www\.pandora\.com/' | sed -E 's/^\[([0-9]+:)?([0-9]+)].*$/\2/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
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
})();
EOF)" -t $tabId
done