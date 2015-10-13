pauseyoutubeanywhere
====================

Play/pause youtube and/or pandora from anywhere using a script and chrome-cli

Once you have this script, you can, for example, create an Automator service which runs the script when a keyboard shortcut is pressed (on Mac OS X).

If you have not installed chrome-cli into `/usr/local/bin/chrome-cli` (the `brew` default), create a file next to your scripts called `chrome-cli-custom-path` and put the path to your chrome-cli on the first line.  This allows the pause and skip master scripts to be run from automator which knows nothing about your path.

Thanks to [@cobbal](https://github.com/cobbal/) and [@sphippen](https://github.com/sphippen/) for invaluable help developing this during work hours.
