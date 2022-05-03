#!/bin/bash

POST_NAME=$1
POST_NAME="${POST_NAME// /-}"
TODAY="$(date +'%Y-%m-%d')"

hugo new posts/$TODAY-$POST_NAME.md
