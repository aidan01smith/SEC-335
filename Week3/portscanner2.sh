#!/bin/bash

hostfile=$1
portfile=$2


# if statement ideas provided by stack overflow

# Basic usage and parameter checking
if [ -z "$hostfile" ] || [ -z "$portfile" ]; then
  echo "Usage: $0 <hostfile> <portfile>"
  exit 1
fi

# Check if files exist
if [ ! -f "$hostfile" ]; then
  echo "Error: Host file '$hostfile' does not exist."
  exit 1
fi

if [ ! -f "$portfile" ]; then
  echo "Error: Port file '$portfile' does not exist."
  exit 1
fi

echo "host,port,status"

for host in $(cat "$hostfile"); do
  for port in $(cat "$portfile"); do
    if timeout 0.1 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
      echo "$host,$port,open"
    else
      echo "$host,$port,closed"
    fi
  done
done

