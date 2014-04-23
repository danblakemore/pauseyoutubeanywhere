#!/usr/bin/env zsh
chrome-cli list links | grep '//www\.pandora\.com/' | sed -E 's/^\[[0-9]+:([0-9]+)].*$/\1/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
(function () {
    // just take control of the tab (so play/pause will work too).
    $(".skipButton").click();
    thispandorabeingcontrolledbyscripts = true;
})();
EOF)" -t $tabId
done