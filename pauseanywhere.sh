#!/usr/bin/env zsh
BASEDIR=$(dirname $0)

chromeclipath=/usr/local/bin/chrome-cli
custompathfile="$BASEDIR"/chrome-cli-custom-path

# check for alternate path for chrome-cli
if [ -f $custompathfile ];
then
    chromeclipath=$(head -n 1 $custompathfile)
fi

"$BASEDIR"/pausebandcampanywhere.sh $chromeclipath &
"$BASEDIR"/pausepandoraanywhere.sh $chromeclipath &
"$BASEDIR"/pauseyoutubeanywhere.sh $chromeclipath &

