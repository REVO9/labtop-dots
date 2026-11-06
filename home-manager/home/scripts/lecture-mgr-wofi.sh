#!/bin/sh

LECTURE=$(lecture-mgr lectures | wofi -S dmenu)
ACTION=$(wofi -S dmenu << EOF
open homepage
open script
open notes
open directory in terminal
open directory in rnote
commit
EOF
)

case $ACTION in
    "open homepage")
        lecture-mgr homepage $LECTURE
        ;;

    "open script")
        lecture-mgr script $LECTURE
        ;;

    "open notes")
        lecture-mgr notes $LECTURE
        ;;

    "open directory in terminal")
        kitty $(lecture-mgr path $LECTURE)
        ;;

    "open directory in rnote")
        rnote $(lecture-mgr path $LECTURE)
        ;;

    "commit")
        lecture-mgr commit $LECTURE
        ;;
esac
