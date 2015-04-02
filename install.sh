#!/bin/bash
# Yocto-SPDX install script

if [[ "$1" == "" ]]; then
    echo "Usage: $0 <poky-root-dir>"
    exit 1
fi

if [[ ! -d "$1" ]]; then
    echo "$0: $1: Not a directory"
    exit 1
fi

REPO=$(dirname $0)
POKY=$1
CLASSDIR=$POKY/meta/classes
CONFDIR=$POKY/meta/conf

if [[ -f $CLASSDIR/spdx.bbclass ]]; then
    cp $CLASSDIR/spdx.bbclass $CLASSDIR/spdx.bbclass.old
    echo "$0: created spdx.bbclass.old"
fi

if [[ -f $CONFDIR/licenses.conf ]]; then
    cp $CONFDIR/licenses.conf $CONFDIR/licenses.conf.old
    echo "$0: created licenses.conf.old"
fi

cp $REPO/src/spdx.bbclass $CLASSDIR/
cp $REPO/src/licenses.conf $CONFDIR/
echo "$0: done"
