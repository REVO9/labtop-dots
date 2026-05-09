#!/usr/bin/env bash

sudo -v

PWD=$(pwd)
FLAKE_PATH=/etc/nixos/
FLAKE_LOCK_PATH=$FLAKE_PATH/flake.lock
FLAKE_LOCK_BAK_PATH=$FLAKE_PATH/flake.lock.bak


abort() {
    echo "FATAL nixos-rebuild switch failed. Restoring flake.lock" >&2
    mv -f $FLAKE_LOCK_BAK_PATH $FLAKE_LOCK_PATH || exit 1
    exit 1
}

cp $FLAKE_LOCK_PATH $FLAKE_LOCK_BAK_PATH || exit 1

nix flake update --flake $FLAKE_PATH || exit 1

sudo nixos-rebuild switch --flake $FLAKE_PATH || abort
git -C $FLAKE_PATH commit $FLAKE_LOCK_PATH -m "updated flake" || abort
rm $FLAKE_LOCK_BAK_PATH
echo "Success"
exit 0

