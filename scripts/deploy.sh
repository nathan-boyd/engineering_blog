#!/bin/bash

set -e

logInfo "hugo version"
hugo --version

logInfo "building"
hugo

logInfo "deploying"
hugo deploy --target=s3

logInfo "done"
