#!/usr/bin/env zsh
chrome-cli list links | grep 'bandcamp\.com/' | sed -E 's/^\[([0-9]+:)?([0-9]+)].*$/\2/' | \
while read tabId; do
    chrome-cli execute "$(cat <<'EOF'
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
})();
EOF)" -t $tabId
done