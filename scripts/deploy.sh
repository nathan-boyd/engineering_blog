#!/bin/bash

set -e

source $HOME/.zshfn/logInfo

logInfo "hugo version"
hugo version

logInfo "building"
hugo

logInfo "deploying"
hugo deploy --target=s3

logInfo "done"
