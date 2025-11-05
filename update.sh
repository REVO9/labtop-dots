#!/usr/bin/env bash

sudo echo ""

FLAKE_PATH=/etc/nixos/
FLAKE_LOCK_PATH=$FLAKE_PATH/flake.lock
FLAKE_LOCK_BAK_PATH=$FLAKE_PATH/flake.lock.bak

cp $FLAKE_LOCK_PATH $FLAKE_LOCK_BAK_PATH || exit 1

nix flake update --flake $FLAKE_PATH

sudo nixos-rebuild switch --flake $FLAKE_PATH || abort
git commit flake.lock -m "updated flake" || abort
rm $FLAKE_LOCK_BAK_PATH
echo "Success"
exit 0

abort() {
    echo "FATAL nixos-rebuild switch failed. Restoring flake.lock" >&2
    mv -f $FLAKE_LOCK_BAK_PATH $FLAKE_LOCK_PATH || exit 1
    exit 1
}
