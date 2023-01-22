#!/bin/bash

POST_NAME=$1
POST_NAME="${POST_NAME// /-}"
TODAY="$(date +'%Y-%m-%d')"
POST_TITLE="$TODAY-$POST_NAME"

mkdir "img/$POST_TITLE"
hugo new "posts/$POST_TITLE.md"
