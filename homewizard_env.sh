#!/bin/sh

export HOMEWIZARD_HOST="$(cat "${CREDENTIALS_DIRECTORY:-.}/.homewizard-host")"
