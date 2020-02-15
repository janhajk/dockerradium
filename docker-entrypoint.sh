#!/bin/bash -e

echo "Starting Radium Daemon..."
/home/radium/radium/radium-0.11-1.5.1.0/src/radiumd > /dev/null &


echo "Waiting for daemon..."
sleep 60