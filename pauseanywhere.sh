#!/usr/bin/env zsh
BASEDIR=$(dirname $0)
$BASEDIR/pausebandcampanywhere.sh &
$BASEDIR/pausepandoraanywhere.sh &
$BASEDIR/pauseyoutubeanywhere.sh &

