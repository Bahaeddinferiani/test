#!/bin/bash

if [ "$DAEMON" = "namenode" ]; then
  chmod +x namenode.sh
  ./namenode.sh
elif [ "$DAEMON" = "datanode" ]; then
  chmod +x datanode.sh
  ./datanode.sh
elif [ "$DAEMON" = "yarn" ]; then
  chmod +x yarn.sh
  ./yarn.sh
elif [ "$DAEMON" = "manager" ]; then
  chmod +x manager.sh
  ./manager.sh
else
  echo "Unknown daemon type: $DAEMON"
  exit 1
fi