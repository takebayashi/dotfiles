#!/usr/bin/env zsh

DIR=$(cd $(dirname $0) && pwd)

for FILE in $DIR/*; do
  if [ "$(basename $FILE)" != "$(basename $0)" ]; then
    if [ ! -e "$HOME/.$(basename $FILE)" ]; then
      ln -s $FILE $HOME/.$(basename $FILE)
    fi
  fi
done
