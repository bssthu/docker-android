#!/bin/bash

set -e

IFS=' '
read -ra args <<< "$@"

for package in "${args[@]}"; do
  cmd="sdkmanager ${package}"
  echo $cmd
  $cmd
done

