#!/usr/bin/env bash

tmpfile=$(mktemp /tmp/tuir.cfg.XXXXXX)
gpg -q -d /mnt/SDcard/Nextcloud/.password-store/tuir.cfg.gpg>$tmpfile

function rmtemp {
    sleep 5
    rm -rf "$tmpfile" &
}

rmtemp &
tuir --config $tmpfile
